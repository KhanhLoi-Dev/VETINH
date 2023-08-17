--CPOL = 0, CPHA = 0, MSB transmit
--không được ghi data vào khi chưa bật device
--bật device bằng cách nss= '0'
--sự kiện SCK xay ra sau khi nss = '0', sự kiện NSS xay ra sau khi sự kiện SCK
--ghi sự kiện CRC ngay sau khi ghi data cuối cùng vào SPI, trước khi data được dịch chuyển sang ARC_DataMiso, đối với truyền một data thì phải ghi sự kiện CRCEvent đồng thời với ghi data vào spi
--phải ghi data mới vào spi trước khi DATAMISO truyền xong
--không được ghi data mới vào spi sau khi ghi sự kiện CRC, phải đợi đến khi data empty trống mới được ghi vào
--sau khi truyền xong crc phải ghi nss = 1
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity SPI_Slave is
	generic(ENT_Leangth: integer:= 8;
			ENT_CRCEnable: boolean:= true;--bật CRC Check
			ENT_Polynomial: std_logic_vector(8 downto 0):= "100000101"
			);
	port(ENT_ClkIn: in std_logic:= '0';
		ENT_DataNewEvent: in std_logic:= '0';
		ENT_DataIn: in std_logic_vector((ENT_Leangth -1) downto 0):= (others=> '0');
		ENT_DataOut: out std_logic_vector((ENT_Leangth -1) downto 0):= (others=> '0');
		ENT_SCK: in std_logic:= '0';
		ENT_MOSI: in std_logic:= '0';
		ENT_MISO: out std_logic:= '0';
		ENT_NSS: in std_logic:= '1';
		ENT_DataEmpty: out std_logic:= '1';
        ENT_DataReceiveEvent: out std_logic:= '0';--sự kiện khi nhận xong một data
		ENT_DeviceResetEvent: std_logic:= '0';
		ENT_CRCEvent: std_logic:= '0';--kích hoặt CRC
		ENT_Error: out std_logic_vector(2 downto 0):= (others=> '0')--lỗi
		);
end entity SPI_Slave;
architecture SPI_Slave_Behavioral of SPI_Slave is
	--DeviceStatus
	signal ARC_DeviceStatus: boolean:= false;-- SPI chưa hoạt động
	--DataMisoTemp
	signal ARC_DataMisoTemp: std_logic_vector((ENT_Leangth -1)downto 0):= (others=> '0');--data tạm 
	signal ARC_DataMisoTempEmptyFlag: std_logic:= '1';--cờ data trống
	signal ARC_DataMisoTempEmptyReset: std_logic:= '0';--reset cờ 
	signal ARC_DataMisoTempError: std_logic:= '0';--lỗi khi data tạm thời chưa được ghi vào DataMiso lại ghi data mới vào
	--DataMiso
	signal ARC_DataMiso: std_logic_vector((ENT_Leangth -1) downto 0):= (others=> '0');
	signal ARC_DataMisoReset: std_logic:= '0';--reset cờ
	signal ARC_DataMisoEmptyFlag: std_logic:= '1';-- cờ data Miso trống
	--DataMosi
	signal ARC_DataMosi: std_logic_vector((ENT_Leangth -1) downto 0):= (others => '0');
	--signal ARC_DataMosiEmptyFlag: std_logic:= '1';--chưa có data trong dataMosi
	signal ARC_DataMosiEmptySet: std_logic:= '0';----set tín hiệu ARC_DataMosiEmptyFlag
	signal ARC_DataMosiEmptyReset: std_logic:= '0';--reset tín hiệu ARC_DataMosiEmptyFlag
	--signal ARC_DataTransmitEnd: boolean:= false;--tín hiệu cho thay chưa bắt đầu truyền data cuối(không phải truyền data crc)
	signal ARC_DataReceiveEvent: std_logic:= '0';--sự kiện khi nhận xong một frame data
	--DataMosiTemp
	signal ARC_DataMosiTemp: std_logic_vector((ENT_Leangth -1) downto 0):= (others=> '0');-- data mosi tạm thời, chờ đọc
	--Counter
	signal ARC_Counter: integer range (ENT_Leangth -1) downto 0:= (ENT_Leangth -1);
	signal ARC_CounterSCKEvent: std_logic:= '0';--sự kiện bộ đếm
	signal ARC_CounterSCKEventReset: std_logic:= '0';--reset tín hiệu ARC_CounterSCKEvent
	signal ARC_DataFrameComputer: boolean:= false;-- chưa truyền xong một khung data
	--NSS
	signal ARC_NSSErrorHighNSS: std_logic:= '0';--lỗi nss tăng lênh mức '1'
	signal ARC_NSSErrorLowNSS: std_logic:= '0';--lỗi nss xuốn mức '0'
	--CRC Miso
	constant ARC_CRCZeroVector: std_logic_vector(((ENT_Leangth *2) -1) downto 0):= (others=> '0');
	constant ARC_CRCPolynomial: std_logic_vector(((ENT_Leangth *2) -1) downto 0):= ENT_Polynomial&((ENT_Leangth *2) -1 - ENT_Polynomial'length downto 0=> '0');
	alias ARC_CRCCLK is ENT_ClkIn;
	alias ARC_CRCDataNewEvent is ARC_DataMisoEmptyFlag;
	signal ARC_CRCCheckError: std_logic:= '0';--không có lỗi khi kiểm tra crc
	signal ARC_CRCDataNewEventReset: std_logic:= '0';--reset 
	signal ARC_CRCDataNewEventFlag: std_logic:= '0';--cờ cho biết có data mới trong DataMiso
	signal ARC_CRCDataInput: std_logic_vector(((ENT_Leangth *2)-1) downto 0):= (others=> '0');
	signal ARC_CRCDataInputCompute: std_logic:= '0';-- đã hết data, tiếng hành hoàng thành crc
	signal ARC_CRCEvent: std_logic:= '0';--sự kiện khi ENT_CRCEvent tăng lênh '1'
	signal ARC_CRCEventReset: std_logic:= '0';--reset ARC_CRCEvent
	signal ARC_CRCDataOutput: std_logic_vector(ENT_Leangth -1 downto 0):= (others=> '0');--data CRC
	signal ARC_CRCDataOne: boolean:= true;--chỉ truyền 1 data
	--signal ARC_CRCTransmitComputer: boolean:= false;--chưa truyền xong crc
	--signal ARC_CRCTransmitComputerReset: std_logic:= '0';--reset
	--signal ARC_CRCTransmitStart: boolean:= false;-- bắt đầu truyền crc
	--signal ARC_CRCTransmitStartReset: std_logic:= '0';--reset tín hiệu ARC_CRCTransmitStart;
	signal ARC_CRCStart: boolean:= false;-- chưa bắt đầu truyền crc
	signal ARC_CRCStartReset: std_logic:= '0';-- Reset
	--CRC MOSI
	alias ARC_CRCDataMosiInputNewEvent is ARC_DataReceiveEvent;--sự kiện khi có data mới
	alias ARC_CRCDataMosiReceiveComputer is ARC_CRCStart;-- chưa nhận hết data
	alias ARC_CRCDataMosiCheckEvent is ARC_DataMosiEmptySet;--sự kiện kiểm tra crc nhận từ server 
	signal ARC_CRCDataMosiCheckAccess: boolean:= false;-- không cho phép kiểm tra crc
	signal ARC_CRCDataMosiTemp: std_logic_vector((ENT_Leangth *2) -1 downto 0):= (others=> '0');
	signal ARC_CRCDataMosiOne: boolean:= true;--chỉ nhận 1 data
	signal ARC_CRCDataMosiComputer: std_logic_vector((ENT_Leangth -1) downto 0):= (others=> '0');--data crc khi tính toáng xong
	--signal ARC_CRCDataMosiReceive: std_logic_vector((ENT_Leangth -1) downto 0):= (others=> '0');--crc nhận từ server
	signal ARC_CRCDataMosiComputerEvent: std_logic:= '0';-- sự kiện sau khi tính toán xong crc
	--signal ARC_CRCDataMosiComputerEventReset: std_logic:= '0';--reset
	signal ARC_CRCDataMosiOK: boolean:= false;-- chưa hoàng thành crc
begin	
	--set DataMiSO
	ENT_MISO<= ARC_DataMiso(ARC_Counter);
	ENT_DataOut<= ARC_DataMosiTemp;
	ENT_DataEmpty<= ARC_DataMisoTempEmptyFlag;
	ENT_DataReceiveEvent<= ARC_DataReceiveEvent;
	ENT_Error<= (ARC_NSSErrorHighNSS or ARC_NSSErrorLowNSS) & ARC_DataMisoTempError & ARC_CRCCheckError;
	DataMisoControlInput:process(ENT_DataNewEvent, ARC_DataMisoTempEmptyReset, ENT_DeviceResetEvent)is
		variable PROC_DataMisoTempEmptyFlag: std_logic:= '1';--cờ data temp trống
		variable PROC_DataMisoTempError: std_logic:= '0';--không có lỗi
    begin
		if(ENT_DeviceResetEvent = '1' or ARC_DataMisoTempEmptyReset = '1')then
			--device reset
			PROC_DataMisoTempError:= '0';--không có lỗi
			ARC_DataMisoTempError<= PROC_DataMisoTempError;	
			ARC_DataMisoTemp<= (others=> '0');
			ARC_DataMisoTempEmptyFlag<= '1';
			PROC_DataMisoTempEmptyFlag:= '1';
		elsif(ENT_DataNewEvent'event and ENT_DataNewEvent = '1')then
			ARC_DataMisoTemp<= ENT_DataIn;--data mới
			ARC_DataMisoTempEmptyFlag<= '0';
			PROC_DataMisoTempEmptyFlag:= ARC_DataMisoEmptyFlag;
			if(PROC_DataMisoTempEmptyFlag = '0')then--có data, lỗi(data củ trong datamisotemp bị lọi bỏ)
				PROC_DataMisoTempError:= '1';--lỗi, data trong DataMisoTemp chưa được truyền đi
				ARC_DataMisoTempError<= PROC_DataMisoTempError;	
			else
				--data temp không có data
				PROC_DataMisoTempError:= ARC_DataMisoTempError;
				ARC_DataMisoTempError<= PROC_DataMisoTempError;	
			end if;
		end if;
	end process DataMisoControlInput;
	ControlCRC:process(ENT_ClkIn, ARC_CRCStartReset, ARC_DeviceStatus, ENT_DeviceResetEvent, ARC_CRCEvent, ARC_DataMisoTempEmptyFlag, ARC_DataMisoEmptyFlag)is
    begin
		if(ARC_CRCStartReset = '1' or ARC_DeviceStatus = false or ENT_DeviceResetEvent = '1')then
			ARC_CRCStart<= false;
		elsif(ENT_ClkIn'event and ENT_ClkIn = '1' and ARC_CRCEvent = '1' and ARC_DataMisoTempEmptyFlag = '1' and ARC_DataMisoEmptyFlag = '0')then
			ARC_CRCStart<= true;
		end if;
	end process ControlCRC;
	ControlCRCReset: process(ENT_ClkIn, ENT_NSS)is
    begin
		if(ENT_ClkIn'event and ENT_ClkIn = '1')then
			if(ENT_NSS = '1')then
				ARC_CRCStartReset<= '1';
			else
				ARC_CRCStartReset<= '0';
			end if;
		end if;
	end process ControlCRCReset;
	DataMisoControl: process(ENT_ClkIn, Arc_DataMisoReset, ENT_DeviceResetEvent)is
		variable PROC_DataMiso: std_logic_vector((ENT_Leangth -1) downto 0):= (others=> '0');
		variable PROC_DataMisoEmptyFlag: std_logic:= '1';--dataMiso trống
		variable PROC_DataTransmitEnd: boolean:= false;-- chưa bắt đầu truyền data cuối cùng(không phải truyền crc)
    begin
		if(ENT_DeviceResetEvent = '1' or Arc_DataMisoReset = '1')then
			PROC_DataMiso:= (others=> '0');
			PROC_DataMisoEmptyFlag:= '1';--data miso trống
			ARC_DataMiso<= PROC_DataMiso;
			ARC_DataMisoEmptyFlag<= PROC_DataMisoEmptyFlag;
			ARC_DataMisoTempEmptyReset<= '0';
			ARC_CRCDataInputCompute<= '0';
			PROC_DataTransmitEnd:= false;
			--ARC_DataTransmitEnd<= PROC_DataTransmitEnd;
		elsif(ENT_ClkIn'event and ENT_ClkIn = '1')then
			if(PROC_DataMisoEmptyFlag = '1' and ARC_DataMisoTempEmptyFlag = '0' and ENT_CRCEnable = false)then
				-- ghi data mới khi DataMiso đã truyền xong và dataMioTemp có data mới, CRC bị disable, 
				PROC_DataMiso:= ARC_DataMisoTemp;
				ARC_DataMiso<= PROC_DataMiso;
				PROC_DataMisoEmptyFlag:= '0';--data miso KHÔNG trống
				ARC_DataMisoEmptyFlag<= PROC_DataMisoEmptyFlag;
				ARC_DataMisoTempEmptyReset<= '1';--RESERT DATAMISO EMPTY FLAG
				PROC_DataTransmitEnd:= false;
				if(ARC_CRCEvent = '1')then
					ARC_CRCDataInputCompute<= '1';--đã nhận data miso cuối cùng, bắt đầu hoàng thành crc
				else
					ARC_CRCDataInputCompute<= '0';
				end if;
			elsif(PROC_DataMisoEmptyFlag = '1' and ARC_DataMisoTempEmptyFlag = '0' and ENT_CRCEnable = true and ARC_CRCStart = false and PROC_DataTransmitEnd = false)then
				-- ghi data mới khi DataMiso đã truyền xong và dataMioTemp có data mới, CRC bị disable, 
				PROC_DataMiso:= ARC_DataMisoTemp;
				ARC_DataMiso<= PROC_DataMiso;
				PROC_DataMisoEmptyFlag:= '0';--data miso KHÔNG trống
				ARC_DataMisoEmptyFlag<= PROC_DataMisoEmptyFlag;
				ARC_DataMisoTempEmptyReset<= '1';--RESERT DATAMISO EMPTY FLAG
				if(ARC_CRCEvent = '1')then
					ARC_CRCDataInputCompute<= '1';--đã nhận data miso cuối cùng, bắt đầu hoàng thành crc
					PROC_DataTransmitEnd:= true;-- bắt đầu truyền data cuối 
				else
					ARC_CRCDataInputCompute<= '0';
					PROC_DataTransmitEnd:= false;
				end if;
			elsif(ENT_CRCEnable = true and ARC_DataFrameComputer = true and ARC_CRCStart = true and PROC_DataTransmitEnd = true)then
				--CRC= enable, và chưa truyền crc, đã truyền xông frame data cuối cùng
				PROC_DataMiso:= ARC_CRCDataOutput;--lấy data crc
				ARC_DataMiso<= PROC_DataMiso;
				PROC_DataMisoEmptyFlag:= '0';--data miso KHÔNG trống
				ARC_DataMisoEmptyFlag<= PROC_DataMisoEmptyFlag;
				ARC_DataMisoTempEmptyReset<= '1';--RESERT DATAMISO EMPTY FLAG
				ARC_CRCDataInputCompute<= '0';
				PROC_DataTransmitEnd:= true;-- bắt đầu truyền data cuối 
			else
				PROC_DataMiso:= ARC_DataMiso;
				ARC_DataMiso<= PROC_DataMiso;
				ARC_DataMisoTempEmptyReset<= '0';
				PROC_DataMisoEmptyFlag:= '0';
				PROC_DataMisoEmptyFlag:= ARC_DataMisoEmptyFlag;
				ARC_CRCDataInputCompute<= '0';
			end if;
			--ARC_DataTransmitEnd<= PROC_DataTransmitEnd;
		end if;
	end process DataMisoControl;
	--reset signal ARC_DataMosiEmptyFlag
	ResetDataMisoEmptyFlag: process(ENT_ClkIn, ARC_DeviceStatus)is
    begin
		if(ENT_ClkIn'event and ENT_ClkIn = '1' and ARC_DeviceStatus = true)then
			if(ARC_Counter = (ENT_Leangth -1) and ARC_DataFrameComputer = true)then
				if(ENT_CRCEnable = true and ARC_CRCStart = false)then
					ARC_DataMisoReset<= '1';--reset datamisoEmptyFlag
				elsif(ENT_CRCEnable = false)then
					ARC_DataMisoReset<= '1';--reset datamisoEmptyFlag
				else
					ARC_DataMisoReset<= '0';
				end if;
			else
				ARC_DataMisoReset<= '0';
				--ARC_CRCTransmitComputerReset<= '0';
			end if;
		end if;
	end process ResetDataMisoEmptyFlag;

	--DeviceEnable
	DeviceEnableHighNSS: process(ENT_NSS, ENT_DeviceResetEvent, ARC_DeviceStatus)is
		variable PROC_NSSError: std_logic:= '0';--lỗi nss
    begin
		if(ENT_DeviceResetEvent = '1' and ARC_DeviceStatus = false)then
			PROC_NSSError:= '0';
			ARC_NSSErrorHighNSS<= PROC_NSSError;
		elsif(ENT_NSS'event and ENT_NSS = '1')then
			if(ARC_Counter = (ENT_Leangth -1))then
				PROC_NSSError:= ARC_NSSErrorHighNSS;
				ARC_NSSErrorHighNSS<= PROC_NSSError;
			elsif(ARC_CRCStart = true)then
				--spi đã tắt
				PROC_NSSError:= ARC_NSSErrorHighNSS;
				ARC_NSSErrorHighNSS<= PROC_NSSError;
			else
				--lỗi, nss lênh múc cao trong khi đang truyền data
				PROC_NSSError:= '1';--lỗi
				ARC_NSSErrorHighNSS<= PROC_NSSError;
			end if;
		end if;
	end process DeviceEnableHighNSS;
	DeviceEnableLowNSS: process(ENT_NSS, ENT_DeviceResetEvent, ARC_DeviceStatus)is
		variable PROC_NSSError: std_logic:= '0';--lỗi nss
		variable PROC_DeviceStatus: boolean:= false;-- device chua active
    begin
		if(ENT_NSS = '1' or ENT_DeviceResetEvent = '1')then
			PROC_DeviceStatus:= false;-- active device
			ARC_DeviceStatus<= PROC_DeviceStatus;
			PROC_NSSError:= '0';
			ARC_NSSErrorLowNSS<= PROC_NSSError;
		elsif(ENT_NSS'event and ENT_NSS = '0')then
			if(ARC_Counter = (ENT_Leangth -1))then
				PROC_DeviceStatus:= true;-- active device
				ARC_DeviceStatus<= PROC_DeviceStatus;
				PROC_NSSError:= ARC_NSSErrorLowNSS;
				ARC_NSSErrorLowNSS<= PROC_NSSError;
			else
				--lỗi, nss giảm xuốn mức 0 trong khi đang truyền data
				PROC_NSSError:= '1';--lỗi
				ARC_NSSErrorLowNSS<= PROC_NSSError;
				PROC_DeviceStatus:= ARC_DeviceStatus;
				ARC_DeviceStatus<= PROC_DeviceStatus;
			end if;
		end if;
	end process DeviceEnableLowNSS;
	---------------------------------------------------------------------------------------------------------------------------
	--Counter
	Counter:process(ENT_ClkIn)is
		variable PROC_I: integer range (ENT_Leangth -1) downto 0:= (ENT_Leangth -1);
		variable PROC_CounterSCKEventReset: std_logic:= '0';--reset tín hiệu ARC_CounterSCKEvent
		variable PROC_DataFrameComputer: boolean:= false; -- chưa ruyền xong một khung data
    begin
		if(ENT_ClkIn'event and ENT_ClkIn = '1')then
			if(ARC_DeviceStatus = true)then
				--Device đã hoặt động và bắt đầu đếm
				if(ARC_CounterSCKEvent = '1')then
					PROC_CounterSCKEventReset:= '1';--RESERT tin hiệu ARC_CounterSCKEvent
					ARC_CounterSCKEventReset<= PROC_CounterSCKEventReset;
					if(PROC_I = 0)then
						PROC_I:= ENT_Leangth -1;
						PROC_DataFrameComputer:= true;--đã truyền xong một khung data
						ARC_DataFrameComputer<= PROC_DataFrameComputer;
					else
						PROC_I:= PROC_I -1;
						PROC_DataFrameComputer:= false;
						ARC_DataFrameComputer<= PROC_DataFrameComputer;
					end if;
					ARC_Counter<= PROC_I;
				else
					PROC_I:= ARC_Counter;
					ARC_Counter<= PROC_I;
					PROC_CounterSCKEventReset:= '0';
					ARC_CounterSCKEventReset<= PROC_CounterSCKEventReset;
					PROC_DataFrameComputer:= ARC_DataFrameComputer;
					ARC_DataFrameComputer<= PROC_DataFrameComputer;
				end if;
			else
				--chưa hoạt động
			end if;
		end if;
	end process Counter;
	CounterEvent: process(ENT_SCK, ARC_CounterSCKEventReset, ARC_DeviceStatus, ENT_DeviceResetEvent)is
    begin
		if(ARC_CounterSCKEventReset = '1' or ARC_DeviceStatus = false or ENT_DeviceResetEvent = '1')then
			--reset tín hiệu ARC_CounterSCKEvent
			ARC_CounterSCKEvent<= '0';
		elsif(ENT_SCK'event and ENT_SCK = '0' and ARC_DeviceStatus = true)then
		--giảm giá trị của bộ đếm counter
			ARC_CounterSCKEvent<= '1';
		end if;
	end process CounterEvent;
	---------------------------------------------------------------------------------------------------------------------------
	--DataMosi
	DataMosiControl:process(ENT_SCK, ARC_DataMosiEmptySet ,ARC_DataMosiEmptyReset, ARC_DeviceStatus, ENT_DeviceResetEvent)is
    begin
		if(ARC_DataMosiEmptyReset = '1' OR ARC_DeviceStatus = false or ENT_DeviceResetEvent = '1')then
			--reset
			ARC_DataReceiveEvent<= '0';-- sự kiện đọc data từ mosi
		elsif(ARC_DataMosiEmptySet'event and ARC_DataMosiEmptySet = '1')then
			--lấy data
			ARC_DataReceiveEvent<= '1';-- sự kiện đọc data từ mosi
		end if;
	end process DataMosiControl;
	process(ARC_DataMosiEmptySet)is
		variable PROC_DataMosiTemp: std_logic_vector((ENT_Leangth -1) downto 0):= (others=> '0');
    begin
		if(ARC_DataMosiEmptySet'event and ARC_DataMosiEmptySet = '1')then
			PROC_DataMosiTemp:= ARC_DataMosi;
			ARC_DataMosiTemp<= PROC_DataMosiTemp;
		end if;
	end process;
	GetDataMosi: process(ENT_SCK, ARC_DeviceStatus, ENT_NSS, ENT_DeviceResetEvent)is
		variable PROC_DataMosi: std_logic_vector((ENT_Leangth -1) downto 0):= (others=> '0');
    begin
		if(ENT_DeviceResetEvent = '1' or ENT_NSS = '1' or ARC_DeviceStatus = false)then
			PROC_DataMosi:= (others=> '0');
			ARC_DataMosi<= PROC_DataMosi;
			ARC_DataMosiEmptySet<= '0';
			ARC_DataMosiEmptyReset<= '0';
		elsif(ENT_SCK'event and ENT_SCK = '1')then
			if(ARC_DeviceStatus = true)then
				PROC_DataMosi(ARC_Counter):= ENT_MOSI;
				ARC_DataMosi<= PROC_DataMosi;
				if(ARC_Counter = 0)then
					ARC_DataMosiEmptySet<= '1';--set ENT_DataReceiveEvent
					ARC_DataMosiEmptyReset<= '0';
				else
					ARC_DataMosiEmptySet<= '0';
					ARC_DataMosiEmptyReset<= '1';--reset ENT_DataReceiveEvent
				end if;
			else
				ARC_DataMosiEmptyReset<= '0';
			end if;
		end if;
	end process GetDataMosi;
	---------------------------------------------------------------------------------------------------------------------------
	--CRCMiso
	-- CRC_TransmitComputer:process(ARC_DataFrameComputer)is
    -- begin
	-- 	if(ARC_CRCTransmitComputerReset = '1')then
	-- 		ARC_CRCTransmitComputer<= false;
	-- 	elsif(ARC_DataFrameComputer'event and ARC_DataFrameComputer = true)then
	-- 		if(ARC_DataTransmitEnd = true)then
	-- 			ARC_CRCTransmitComputer<= true;
	-- 		else
	-- 			ARC_CRCTransmitComputer<= false;
	-- 		end if;
	-- 	end if;
	-- end process;
	-- CRC_TransmitStart: process(ARC_CRCDataInputCompute, ARC_CRCTransmitStartReset)is
    -- begin
	-- 	if(ARC_CRCTransmitStartReset = '1')then
	-- 		ARC_CRCTransmitStart<= false;--không cho phép truyền crc
	-- 	elsif(ARC_CRCDataInputCompute'event and ARC_CRCDataInputCompute = '1')then
	-- 		ARC_CRCTransmitStart<= true;--cho phép truyền crc
	-- 	end if;
	-- end process CRC_TransmitStart;
	CRC_Event: process(ENT_CRCEvent, ARC_DeviceStatus, ENT_DeviceResetEvent)is
    begin
		if(ARC_DeviceStatus = false or ENT_DeviceResetEvent = '1')then
			ARC_CRCEvent<= '0';
		elsif(ENT_CRCEvent'event and ENT_CRCEvent = '1')then
			ARC_CRCEvent<= '1';--đả có tín hiệu truyền crc
		end if;
	end process CRC_Event;
	CRC_DataNewEvent: process(ARC_CRCDataNewEvent, ARC_CRCDataNewEventReset, ENT_DeviceResetEvent)is

    begin
		if(ARC_CRCDataNewEventReset = '1' or ENT_DeviceResetEvent = '1')then
			--reset
			ARC_CRCDataNewEventFlag<= '0';
		elsif(ARC_CRCDataNewEvent'event and ARC_CRCDataNewEvent = '0')then
			--khi có data mớ trong datamiso
			ARC_CRCDataNewEventFlag<= '1';--cờ cho biết có data mới trong DataMiso
		end if;
	end process;
	CRC_DataInput: process(ARC_CRCCLK)is
		variable PROC_DataOne: boolean:= true;-- data đầu tiên
		variable PROC_CRCDataInput: std_logic_vector(((ENT_Leangth *2) -1) downto 0):= (others=> '0');
		variable PROC_DataCRC: std_logic_vector(ENT_Leangth -1 downto 0):= (others=> '0');--data CRC
    begin
		if(ARC_CRCCLK'event and ARC_CRCCLK = '1')then
			if(ARC_CRCDataNewEventFlag = '1')then
				ARC_CRCDataNewEventReset<= '1';--reset
				PROC_CRCDataInput:= std_logic_vector(unsigned(PROC_CRCDataInput) sll ENT_Leangth);
				PROC_CRCDataInput((ENT_Leangth -1) downto 0):= ARC_DataMiso;
				ARC_CRCDataInput<= PROC_CRCDataInput;
				if(PROC_DataOne = true)then
					-- data là đầu tiên, không chạy crc
					if(ARC_CRCEvent = '1')then
						--chỉ truyề 1 data, hoàng thành crc
						PROC_CRCDataInput:= std_logic_vector(unsigned(PROC_CRCDataInput) sll ENT_Leangth);
						CRC_EndOneData:for i in ENT_Leangth -1 downto 0 loop
							if(PROC_CRCDataInput((ENT_Leangth *2) -1) = '0')then
								--bit đầu tiên là '0'
								PROC_CRCDataInput:= PROC_CRCDataInput xor ARC_CRCZeroVector;
							else
								PROC_CRCDataInput:= PROC_CRCDataInput xor ARC_CRCPolynomial;
							end if;
							PROC_CRCDataInput:= std_logic_vector(unsigned(PROC_CRCDataInput) sll 1);--dịch sang trái
						end loop CRC_EndOneData;
						PROC_DataCRC:= PROC_CRCDataInput((ENT_Leangth *2) -1 downto ENT_Leangth);
						ARC_CRCDataInput<= PROC_CRCDataInput;
						ARC_CRCDataOutput<= PROC_DataCRC;
						PROC_DataOne:= true;
						ARC_CRCDataOne<= PROC_DataOne;
					else
						PROC_DataOne:= false;
						ARC_CRCDataOne<= PROC_DataOne;
						PROC_DataCRC:= ARC_CRCDataOutput;
						ARC_CRCDataOutput<= PROC_DataCRC;
					end if;
				else
					--chạy crc
					CRC:for i in ENT_Leangth -1 downto 0 loop
						if(PROC_CRCDataInput((ENT_Leangth *2) -1) = '0')then
							--bit đầu tiên là '0'
							PROC_CRCDataInput:= PROC_CRCDataInput xor ARC_CRCZeroVector;
						else
							PROC_CRCDataInput:= PROC_CRCDataInput xor ARC_CRCPolynomial;
						end if;
						PROC_CRCDataInput:= std_logic_vector(unsigned(PROC_CRCDataInput) sll 1);--dịch sang trái
						ARC_CRCDataInput<= PROC_CRCDataInput;
					end loop CRC;
					if(ARC_CRCDataInputCompute = '1')then
						--đã nhận hết data miso
						CRC_End:for i in ENT_Leangth -1 downto 0 loop
							if(PROC_CRCDataInput((ENT_Leangth *2) -1) = '0')then
								--bit đầu tiên là '0'
								PROC_CRCDataInput:= PROC_CRCDataInput xor ARC_CRCZeroVector;
							else
								PROC_CRCDataInput:= PROC_CRCDataInput xor ARC_CRCPolynomial;
							end if;
							PROC_CRCDataInput:= std_logic_vector(unsigned(PROC_CRCDataInput) sll 1);--dịch sang trái
						end loop CRC_End;
						PROC_DataCRC:= PROC_CRCDataInput((ENT_Leangth *2) -1 downto ENT_Leangth);--lấy data CRC khi hoàng thành
						ARC_CRCDataInput<= PROC_CRCDataInput;
						ARC_CRCDataOutput<= PROC_DataCRC;
						PROC_DataOne:= true;
						ARC_CRCDataOne<= PROC_DataOne;
					else
						PROC_DataOne:= false;
						ARC_CRCDataOne<= PROC_DataOne;
						PROC_DataCRC:= ARC_CRCDataOutput;
						ARC_CRCDataOutput<= PROC_DataCRC;
					end if;
				end if;
			else
				ARC_CRCDataNewEventReset<= '0';
				PROC_DataCRC:= ARC_CRCDataOutput;
				ARC_CRCDataOutput<= PROC_DataCRC;
				PROC_CRCDataInput:= ARC_CRCDataInput;
				ARC_CRCDataInput<= PROC_CRCDataInput;
				PROC_DataOne:= ARC_CRCDataOne;
				ARC_CRCDataOne<= PROC_DataOne;
			end if;
		end if;
	end process CRC_DataInput;
	---------------------------------------------------------------------------------------------------------------------------
	--CRCMosi
	DataInputCRC:process(ARC_CRCDataMosiInputNewEvent, ARC_DeviceStatus, ENT_DeviceResetEvent)is
		variable PROC_CRCDataMosiTemp: std_logic_vector((ENT_Leangth *2) -1 downto 0):= (others=> '0');
		variable PROC_CRCOneData: boolean:= true;-- chỉ nhận 1 data
		variable PROC_CRCDataComputer: std_logic_vector((ENT_Leangth -1) downto 0):=(others=> '0');--data crc đã hòang thành
		variable PROC_CRCMosiOK: boolean:= false;-- chưa hoành thành crc
    begin
		if(ENT_DeviceResetEvent = '1' or ARC_DeviceStatus = false)then
			--reset
			PROC_CRCDataMosiTemp:= (others=> '0');
			PROC_CRCOneData:= true;
			PROC_CRCDataComputer:= (others=> '0');
			ARC_CRCDataMosiTemp<= PROC_CRCDataMosiTemp;
			ARC_CRCDataMosiOne<= PROC_CRCOneData;
			ARC_CRCDataMosiComputer<= PROC_CRCDataComputer;--Data khi tính toáng xong crc
			PROC_CRCMosiOK:= false;
			ARC_CRCDataMosiOK<= PROC_CRCMosiOK;
		elsif(ARC_CRCDataMosiInputNewEvent'event and ARC_CRCDataMosiInputNewEvent = '1' and ENT_CRCEnable = true and PROC_CRCMosiOK = false)then
			if(PROC_CRCOneData = true)then
				--mới nhận được 1 data
				PROC_CRCOneData:= false;
				ARC_CRCDataMosiOne<= PROC_CRCOneData;
				if(ARC_CRCDataMosiReceiveComputer = true)then
					--đã nhận hết data
					PROC_CRCDataMosiTemp(ENT_Leangth -1 downto 0):= ARC_DataMosiTemp;
					ARC_CRCDataMosiTemp<= PROC_CRCDataMosiTemp;
					PROC_CRCDataMosiTemp:= std_logic_vector(unsigned(PROC_CRCDataMosiTemp) sll ENT_Leangth);
					CRCMOSIComputerOneData: for i in ENT_Leangth -1 downto 0 loop
						if(PROC_CRCDataMosiTemp((ENT_Leangth *2) -1) = '0')then
							PROC_CRCDataMosiTemp:= PROC_CRCDataMosiTemp xor ARC_CRCZeroVector;
						else
							PROC_CRCDataMosiTemp:= PROC_CRCDataMosiTemp xor ARC_CRCPolynomial;
						end if;
						PROC_CRCDataMosiTemp:= std_logic_vector(unsigned(PROC_CRCDataMosiTemp) sll 1);
					end loop CRCMOSIComputerOneData;
					PROC_CRCDataComputer:= PROC_CRCDataMosiTemp((ENT_Leangth *2) -1 downto ENT_Leangth);--Data khi tính toáng xong crc
					ARC_CRCDataMosiTemp<= PROC_CRCDataMosiTemp;
					ARC_CRCDataMosiComputer<= PROC_CRCDataComputer;--Data khi tính toáng xong crc
					ARC_CRCDataMosiComputerEvent<= '1';--đã hoàng thành tính CRC
					PROC_CRCMosiOK:= true;--đã hoàng thành crc
					ARC_CRCDataMosiOK<= PROC_CRCMosiOK;
				else
					--chưa nhận hết data
					PROC_CRCDataMosiTemp:= std_logic_vector(unsigned(PROC_CRCDataMosiTemp) sll ENT_Leangth);
					PROC_CRCDataMosiTemp(ENT_Leangth -1 downto 0):= ARC_DataMosiTemp;
					ARC_CRCDataMosiTemp<= PROC_CRCDataMosiTemp;
					PROC_CRCDataComputer:= ARC_CRCDataMosiComputer;--Data khi tính toáng xong crc
					ARC_CRCDataMosiComputer<= PROC_CRCDataComputer;--Data khi tính toáng xong crc
					PROC_CRCMosiOK:= ARC_CRCDataMosiOK;
					ARC_CRCDataMosiOK<= PROC_CRCMosiOK;
				end if;
			else
				PROC_CRCDataMosiTemp:= std_logic_vector(unsigned(PROC_CRCDataMosiTemp) sll ENT_Leangth);
				PROC_CRCDataMosiTemp(ENT_Leangth -1 downto 0):= ARC_DataMosiTemp;
				PROC_CRCOneData:= ARC_CRCDataMosiOne;
				ARC_CRCDataMosiOne<= PROC_CRCOneData;
				CRCMOSI: for i in ENT_Leangth -1 downto 0 loop
					if(PROC_CRCDataMosiTemp((ENT_Leangth *2) -1) = '0')then
						PROC_CRCDataMosiTemp:= PROC_CRCDataMosiTemp xor ARC_CRCZeroVector;
					else
						PROC_CRCDataMosiTemp:= PROC_CRCDataMosiTemp xor ARC_CRCPolynomial;
					end if;
					PROC_CRCDataMosiTemp:= std_logic_vector(unsigned(PROC_CRCDataMosiTemp) sll 1);
				end loop CRCMOSI;
				if(ARC_CRCDataMosiReceiveComputer = true)then
					--đã nhận hết data
					CRCMOSIComputer: for i in ENT_Leangth -1 downto 0 loop
						if(PROC_CRCDataMosiTemp((ENT_Leangth *2) -1) = '0')then
							PROC_CRCDataMosiTemp:= PROC_CRCDataMosiTemp xor ARC_CRCZeroVector;
						else
							PROC_CRCDataMosiTemp:= PROC_CRCDataMosiTemp xor ARC_CRCPolynomial;
						end if;
						PROC_CRCDataMosiTemp:= std_logic_vector(unsigned(PROC_CRCDataMosiTemp) sll 1);
					end loop CRCMOSIComputer;
					PROC_CRCDataComputer:= PROC_CRCDataMosiTemp((ENT_Leangth *2) -1 downto ENT_Leangth);--Data khi tính toáng xong crc
					ARC_CRCDataMosiComputer<= PROC_CRCDataComputer;--Data khi tính toáng xong crc
					ARC_CRCDataMosiTemp<= PROC_CRCDataMosiTemp;
					ARC_CRCDataMosiComputerEvent<= '1';--đã hoàng thành tính CRC
					PROC_CRCMosiOK:= true;--đã hoàng thành crc
					ARC_CRCDataMosiOK<= PROC_CRCMosiOK;
				else
					--chưa nhận hết data
					PROC_CRCDataComputer:= ARC_CRCDataMosiComputer;--Data khi tính toáng xong crc
					ARC_CRCDataMosiComputer<= PROC_CRCDataComputer;--Data khi tính toáng xong crc
					PROC_CRCDataMosiTemp:= ARC_CRCDataMosiTemp;
					ARC_CRCDataMosiTemp<= PROC_CRCDataMosiTemp;
					PROC_CRCMosiOK:= ARC_CRCDataMosiOK;
					ARC_CRCDataMosiOK<= PROC_CRCMosiOK;
				end if;
			end if;
		end if;
	end process DataInputCRC;
	CRCMosiCheckAccess: process (ENT_ClkIn, ENT_DeviceResetEvent, ARC_DeviceStatus, ARC_Counter, ARC_CRCDataMosiComputerEvent)is
    begin
		if(ENT_DeviceResetEvent = '1' or ARC_DeviceStatus = false)then
			ARC_CRCDataMosiCheckAccess<= false;
		elsif(ENT_ClkIn'event and ENT_ClkIn = '1' and ARC_DeviceStatus = true and ARC_Counter = 1 and ARC_CRCDataMosiComputerEvent = '1')then
			ARC_CRCDataMosiCheckAccess<= true;--CHO HÉP KIỂM TRA CRC
		end if;
	end process CRCMosiCheckAccess;
	CRCMosiCheck:process(ARC_CRCDataMosiCheckEvent, ENT_DeviceResetEvent, ARC_DeviceStatus, ARC_CRCDataMosiCheckAccess)is--kiểm tra crc nhận có trùng với crc đã tính hay không
    begin
		if(ENT_DeviceResetEvent = '1' or ARC_DeviceStatus = false)then
			ARC_CRCCheckError<= '0';--crc giống
		elsif(ARC_CRCDataMosiCheckEvent'event and ARC_CRCDataMosiCheckEvent = '1' and ARC_CRCDataMosiCheckAccess = true)then
			if(ARC_DataMosi = ARC_CRCDataMosiComputer)then
				ARC_CRCCheckError<= '0';--crc giống
			else
				ARC_CRCCheckError<= '1';--crc khác, lỗi
			end if;
		end if;
	end process CRCMosiCheck;
end architecture SPI_Slave_Behavioral;