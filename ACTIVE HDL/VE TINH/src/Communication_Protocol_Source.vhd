library ieee;
use ieee.std_logic_1164.all;
--CPOL = 0, CPHA = 0, MSB transmit
entity SPI_Protocol is
	generic(ENT_MODE: boolean:= true;--true = master, false = slave
			ENT_Leangth: integer:= 16;
			ENT_TsuSI_Min: integer:= 3;
			ENT_TcSCK_Max: integer:= 45;--45 mhz
			ENT_ThNSS_Min: integer:= 90);
	port(ENT_ClkIn: in std_logic:= '0';
		ENT_DataNewEvent: inout std_logic:= '0';
		ENT_DataIn: in std_logic_vector((ENT_Leangth -1) downto 0):= (others=> '0');
		ENT_DataOut: out std_logic_vector((ENT_Leangth -1) downto 0):= (others=> '0');
		ENT_SCK: inout std_logic:= '0';
		ENT_MOSI: inout std_logic:= '0';
		ENT_MISO: inout std_logic:= '0';
		ENT_NSS: inout std_logic:= '1';
		ENT_DataEmpty: out std_logic:= '0';
		ENT_DeviceResetEvent: std_logic:= '0');
end entity SPI_Protocol;
architecture SPI_Protocol_Behavioral of SPI_Protocol is
begin
	ENT_DataNewEvent<= 'Z';
	master: block(ENT_MODE = true)is
		generic(BL_GE_Leangth: integer range 0 to 100:= 16;-- một lần truyền 16 bit(default)
			BL_GE_TsuSI: integer;
			BL_GE_TcSCK: integer;
			BL_GE_ThNSS: integer);
		generic map(BL_GE_Leangth=> ENT_Leangth,
					BL_GE_TsuSI=> ENT_TsuSI_Min,
					BL_GE_TcSCK=> ENT_TcSCK_Max,
					BL_GE_ThNSS=> ENT_ThNSS_Min);
		port(BL_PO_ClkIn: in std_logic:= '0';
			BL_PO_DataNewEvent: in std_logic:= '0';
			BL_PO_Data: in std_logic_vector((BL_GE_Leangth -1) downto 0):= (others=> '0');
			BL_PO_SCK: out std_logic:= '0';
			BL_PO_MOSI: out std_logic:= '0';
			BL_PO_MISO: in std_logic:= '0';
			BL_PO_NSS: out std_logic:= '1';
			BL_PO_DataEmpty: out std_logic:= '0');
		port map(BL_PO_ClkIn=> ENT_ClkIn,
			BL_PO_DataNewEvent=> ENT_DataNewEvent,
			BL_PO_Data=> ENT_DataIn,
			BL_PO_SCK=> ENT_SCK,
			BL_PO_MOSI=> ENT_MOSI,
			BL_PO_MISO=> ENT_MISO,
			BL_PO_NSS=> ENT_NSS,
			BL_PO_DataEmpty=> ENT_DataEmpty);
		signal BL_CLKIn: std_logic;
		signal BL_DataNewEvent: std_logic;
		signal BL_Data: std_logic_vector((BL_GE_Leangth -1) downto 0);
		signal BL_SCK: std_logic;
		signal BL_MOSI: std_logic;
		signal BL_MISO: std_logic;
		signal BL_NSS: std_logic;
		signal BL_DataEmpty: std_logic;
		signal BL_CLK: std_logic:= '0';
		signal BL_Part: integer range 0 to 7:= 0;
		signal BL_Count: integer range 0 to 100;
		signal BL_DataTemp_A: std_logic_vector((BL_GE_Leangth -1) downto 0):= (others=> '0');
		signal BL_DataTemp_B: std_logic_vector((BL_GE_Leangth -1) downto 0):= (others=> '0');
		signal BL_LeangthCount: integer range 0 to (BL_GE_Leangth-1):= 0;
		signal BL_Compare_A: std_logic:= '0';
		signal BL_Compare_B: std_logic:= '0';
		signal BL_Status: boolean:= false;
		signal BL_DataTemp_AStatus: boolean:= false;--false = empty
		signal BL_DataTemp_BStatus: boolean:= false;--false = empty
		signal BL_DataTemp_AStatusReset: std_logic:= '0';
		signal BL_DataTemp_BStatusReset: std_logic:= '0';
		signal BL_DataTemp_BUpdate: std_logic:= '0';
		signal BL_DataEmptyActive: boolean:= false;
		--signal BL_Mosi: std_logic:= '0';
		--signal BL_NSS: std_logic:= '0';
	begin
		BL_CLKIn<= BL_PO_ClkIn when ENT_MODE = true else '0';
		BL_DataNewEvent<= BL_PO_DataNewEvent when ENT_MODE = true else '0';
		BL_PO_SCK<= BL_SCK when ENT_MODE = true else 'Z';
		BL_PO_MOSI<= BL_MOSI when ENT_MODE = true else 'Z';
		BL_MISO<= BL_PO_MISO when ENT_MODE = true else 'Z';
		BL_PO_NSS<= BL_NSS when ENT_MODE = true else 'Z';
		BL_PO_DataEmpty<= BL_DataEmpty when ENT_MODE = true else 'Z';
		BL_CLK<= BL_CLKIn when ((BL_DataTemp_AStatus = true) or (BL_DataTemp_BStatus = true) or (BL_Status = true)) else '0';
		BL_Status<= true when ((BL_DataTemp_AStatus = true) or (BL_DataTemp_BStatus = true)) else false;
		process(BL_DataNewEvent, BL_DataTemp_AStatusReset)is
		begin
			if(BL_DataTemp_AStatusReset = '1')then
				BL_DataTemp_A<= (others=> '0');
				BL_DataTemp_AStatus<= false;
			elsif(BL_DataNewEvent'event and BL_DataNewEvent = '1')then
				BL_DataTemp_A<= BL_PO_Data;
				BL_DataTemp_AStatus<= true;
			end if;
		end process;
		process(BL_CLKIn)is
			variable PROC_DataTemp_B: std_logic_vector((BL_GE_Leangth -1) downto 0):= (others=> '0');
			variable PROC_DataTemp_BStatus: boolean:= false;
			variable PROC_DataTemp_AStatusReset: std_logic:= '0';
    	begin
			if(BL_CLKIn'event and BL_CLKIn = '1')then
				if((BL_Status = true) and (BL_Count = 0))then
					PROC_DataTemp_B:= BL_DataTemp_A;
					PROC_DataTemp_BStatus:= true;
					BL_DataTemp_B<= PROC_DataTemp_B;
					BL_DataTemp_BStatus<= PROC_DataTemp_BStatus;
					PROC_DataTemp_AStatusReset:= '1';
					BL_DataTemp_AStatusReset<= PROC_DataTemp_AStatusReset;
				elsif(BL_DataTemp_BUpdate = '1')then
					if(BL_DataTemp_AStatus = true)then
						PROC_DataTemp_B:= BL_DataTemp_A;
						PROC_DataTemp_BStatus:= true;
						BL_DataTemp_B<= PROC_DataTemp_B;
						BL_DataTemp_BStatus<= PROC_DataTemp_BStatus;
						PROC_DataTemp_AStatusReset:= '1';
						BL_DataTemp_AStatusReset<= PROC_DataTemp_AStatusReset;
					else
						PROC_DataTemp_B:= BL_DataTemp_B;
						PROC_DataTemp_BStatus:= false;
						BL_DataTemp_B<= PROC_DataTemp_B;
						BL_DataTemp_BStatus<= PROC_DataTemp_BStatus;
						PROC_DataTemp_AStatusReset:= '0';
						BL_DataTemp_AStatusReset<= PROC_DataTemp_AStatusReset;
					end if;
				elsif(BL_DataTemp_AStatus = true)then
					PROC_DataTemp_B:= BL_DataTemp_A;
					PROC_DataTemp_BStatus:= true;
					BL_DataTemp_B<= PROC_DataTemp_B;
					BL_DataTemp_BStatus<= PROC_DataTemp_BStatus;
					PROC_DataTemp_AStatusReset:= BL_DataTemp_AStatusReset;
					BL_DataTemp_AStatusReset<= PROC_DataTemp_AStatusReset;
				else
					PROC_DataTemp_AStatusReset:= '0';
					BL_DataTemp_AStatusReset<= PROC_DataTemp_AStatusReset;
				end if;
			end if;
		end process;
		process(BL_CLKIn)is
			variable PROC_Count: integer range 0 to 100:= 0;
		begin
			if(BL_CLKIn'event and BL_CLKIn = '1')then
				if(PROC_Count = 100)then
					--error
					PROC_Count:= 0;
					BL_Count<= PROC_Count;
				elsif(BL_Status = true)then
					if((PROC_Count = (BL_GE_TsuSI *2) +1 +(BL_GE_TcSCK /2)) and (BL_LeangthCount = (BL_GE_Leangth -1)))then
						PROC_Count:= PROC_Count +1;
						BL_Count<= PROC_Count;
						BL_DataTemp_BUpdate<= '1';
					elsif((PROC_Count = (BL_GE_TsuSI +1 +(BL_GE_TcSCK))) and (BL_DataTemp_BStatus = true) and (BL_LeangthCount = 0))then
						PROC_Count:= (BL_GE_TsuSI +1);
						BL_Count<= PROC_Count;
						BL_DataTemp_BUpdate<= '0';
					elsif(((PROC_Count = (BL_GE_TsuSI +1 +(BL_GE_TcSCK))) and (BL_DataTemp_BStatus = false) and (BL_LeangthCount = 0)))then
						PROC_Count:= PROC_Count +1;
						BL_Count<= PROC_Count;
						BL_DataTemp_BUpdate<= '0';
					elsif(PROC_Count = (BL_GE_TsuSI +1 +(BL_GE_TcSCK)))then
						PROC_Count:= (BL_GE_TsuSI +1);
						BL_Count<= PROC_Count;
						BL_DataTemp_BUpdate<= '0';
					elsif((BL_Part = 5) and (PROC_Count >= (BL_GE_TsuSI +1 +BL_GE_ThNSS)))then
						PROC_Count:= 0;
						BL_Count<= PROC_Count;
						BL_DataTemp_BUpdate<= '0';
					else
						PROC_Count:= PROC_Count +1;
						BL_Count<= PROC_Count;
						BL_DataTemp_BUpdate<= '0';
					end if;
				else
					PROC_Count:= 0;
					BL_Count<= PROC_Count;
				end if;
			end if;
		end process;
		process(BL_CLKIn)is
			variable PROC_Part: integer range 0 to 7:= 0;
			variable PROC_DataEmptyActive: boolean:= false;
			variable PROC_LeangthCount: integer range 0 to (BL_GE_Leangth -1):= 0;
		begin
			if(BL_CLKIn'event and BL_CLKIn = '1')then
				if(BL_Count = 0)then
					PROC_Part:= 0;
					BL_Part<= PROC_Part;
					PROC_DataEmptyActive:= BL_DataEmptyActive;
					BL_DataEmptyActive<= PROC_DataEmptyActive;
				elsif(BL_Count = 1)then
					PROC_Part:= 1;
					BL_Part<= PROC_Part;
					PROC_DataEmptyActive:= BL_DataEmptyActive;
					BL_DataEmptyActive<= PROC_DataEmptyActive;
				elsif(BL_Count = (BL_GE_TsuSI +1))then
					PROC_Part:= 2;
					BL_Part<= PROC_Part;
					if(BL_LeangthCount = 0)then
						PROC_DataEmptyActive:= false;
						BL_DataEmptyActive<= PROC_DataEmptyActive;
					else
						PROC_DataEmptyActive:= BL_DataEmptyActive;
						BL_DataEmptyActive<= PROC_DataEmptyActive;
					end if;
				elsif(BL_Count = (BL_GE_TsuSI +1 +(BL_GE_TcSCK /2)))then
					PROC_Part:= 3;
					BL_Part<= PROC_Part;
					PROC_DataEmptyActive:= BL_DataEmptyActive;
					BL_DataEmptyActive<= PROC_DataEmptyActive;
				elsif(BL_Count = ((BL_GE_TsuSI *2) +1 +(BL_GE_TcSCK /2)))then
					if(PROC_LeangthCount = (BL_GE_Leangth -1))then
						PROC_LeangthCount:= 0;
						BL_LeangthCount<= PROC_LeangthCount;
					elsif(PROC_LeangthCount = 0)then
						PROC_LeangthCount:= PROC_LeangthCount +1;
						BL_LeangthCount<= PROC_LeangthCount;
					else
						PROC_LeangthCount:= PROC_LeangthCount +1;
						BL_LeangthCount<= PROC_LeangthCount;
					end if;
					if(PROC_LeangthCount = (BL_GE_Leangth -1))then
						PROC_DataEmptyActive:= BL_DataEmptyActive;
						if(PROC_DataEmptyActive = true) then
							PROC_DataEmptyActive:= false;
							BL_DataEmptyActive<= PROC_DataEmptyActive;
						else
							PROC_DataEmptyActive:= true;
							BL_DataEmptyActive<= PROC_DataEmptyActive;
						end if;
					else
						PROC_DataEmptyActive:= BL_DataEmptyActive;
						BL_DataEmptyActive<= PROC_DataEmptyActive;
					end if;
					PROC_Part:= 4;
					BL_Part<= PROC_Part;
				elsif(BL_Count = (BL_GE_TsuSI +1 +(BL_GE_TcSCK)))then
					PROC_Part:= 5;
					BL_Part<= PROC_Part;
					PROC_DataEmptyActive:= BL_DataEmptyActive;
					BL_DataEmptyActive<= PROC_DataEmptyActive;
				elsif((PROC_Part = 5) and (BL_Count >= (BL_GE_TsuSI +1 +BL_GE_ThNSS)))then
					PROC_Part:= 6;
					BL_Part<= PROC_Part;
				else
				end if;
			end if;
		end process;
		process(BL_CLKIn)is
			variable PROC_SCK: std_logic:= '0';
			variable PROC_Mosi: std_logic:= '0';
			variable PROC_Nss: std_logic:= '1';
		begin
			if(BL_CLKIn'event and BL_CLKIn = '1')then
				if(BL_Part = 0)then
					PROC_SCK:= '0';
					PROC_Mosi:= '0';
					PROC_Nss:= '1';
					BL_SCK<= PROC_SCK;
					BL_Mosi<= PROC_Mosi;
					BL_NSS<= PROC_Nss;
					if(BL_DataEmptyActive = true)then
						BL_DataEmpty<= '1';
					else
						BL_DataEmpty<= '0';
					end if;
				elsif(BL_Part = 1)then--start
					PROC_SCK:= '0';
					PROC_Mosi:= BL_DataTemp_B((BL_GE_Leangth -1) - BL_LeangthCount);
					PROC_Nss:= '0';
					BL_SCK<= PROC_SCK;
					BL_Mosi<= PROC_Mosi;
					BL_NSS<= PROC_Nss;
				elsif(BL_Part = 2)then--sck=1
					PROC_SCK:= '1';
					PROC_Mosi:= BL_Mosi;
					PROC_Nss:= '0';
					BL_SCK<= PROC_SCK;
					BL_Mosi<= PROC_Mosi;
					BL_NSS<= PROC_Nss;
				elsif(BL_Part = 3)then--sck=0
					PROC_SCK:= '0';
					PROC_Mosi:= BL_Mosi;
					PROC_Nss:= '0';
					BL_SCK<= PROC_SCK;
					BL_Mosi<= PROC_Mosi;
					BL_NSS<= PROC_Nss;
				elsif(BL_Part = 4)then--sck=3/4
					PROC_SCK:= '0';
					PROC_Mosi:= BL_DataTemp_B((BL_GE_Leangth -1) - BL_LeangthCount);
					PROC_Nss:= '0';
					BL_SCK<= PROC_SCK;
					BL_Mosi<= PROC_Mosi;
					BL_NSS<= PROC_Nss;
				elsif(BL_Part = 5)then--sck = 0
					PROC_SCK:= '0';
					PROC_Mosi:= BL_Mosi;
					PROC_Nss:= '0';
					BL_SCK<= PROC_SCK;
					BL_Mosi<= PROC_Mosi;
					BL_NSS<= PROC_Nss;
					if(BL_DataEmptyActive = true and BL_LeangthCount = 0)then
						BL_DataEmpty<= '1';
					else
						BL_DataEmpty<= '0';
					end if;
				elsif(BL_Part = 6)then--end , dataempty = 1, nss = 1
					PROC_SCK:= '0';
					PROC_Mosi:= BL_Mosi;
					PROC_Nss:= '1';
					BL_SCK<= PROC_SCK;
					BL_Mosi<= PROC_Mosi;
					BL_NSS<= PROC_Nss;
				end if;
			end if;
		end process;
	end block master;
	Slave: block(ENT_MODE = false)is
		generic(BL_GE_Leangth: integer range 0 to 100:= 16);
		generic map(BL_GE_Leangth => ENT_Leangth);
		port(BL_PO_ClkIn: in std_logic:= '0';
			BL_PO_SCK: in std_logic;
			BL_PO_MOSI: in std_logic;
			BL_PO_MISO: out std_logic:= '0';
			BL_PO_NSS: in std_logic:= '1';
			BL_PO_DataOut: out std_logic_vector(BL_GE_Leangth- 1 downto 0):= (others=> '0');
			BL_PO_DataIn: in std_logic_vector(BL_GE_Leangth -1 downto 0):= (others=> '0');
			BL_PO_DataNewEvent: in std_logic:= '0';
			BL_PO_DataReceiveNewEvent: out std_logic:= '0');
		port map(BL_PO_ClkIn => ENT_ClkIn,
				BL_PO_SCK=> ENT_SCK,
				BL_PO_MOSI=> ENT_MOSI,
				BL_PO_MISO=> ENT_MISO,
				BL_PO_NSS=> ENT_NSS,
				BL_PO_DataIn=> ENT_DataIn,
				BL_PO_DataOut=> ENT_DataOut,
				BL_PO_DataNewEvent=> ENT_DataNewEvent);
		signal BL_CLKIn: std_logic;
		signal BL_SCK: std_logic:= '0';
		signal BL_mosi: std_logic:= '0';
		signal BL_miso: std_logic:= '0';
		signal BL_nss: std_logic:= '0';
		signal BL_DataNewEvent: std_logic:= '0';
		signal BL_DataReceiveEvent: std_logic:= '0';--sự kiện khi data nhận được hoàng thành
		--DeviceStatus
		signal BL_DeviceStatus: boolean:= false;-- chưa active
		--DeviceCount
		--DataCount
		signal BL_DataCount: integer range (ENT_Leangth -1) downto 0:= (ENT_Leangth -1);
		signal BL_DataCountEnable: boolean:= false;--cho phép bộ đếm 
		signal BL_DataCountClock: std_logic:= '0';
		--DataMiso
		signal BL_DataMiso: std_logic_vector((ENT_Leangth -1)downto 0):= (others=> '0');--data đang truyền
		signal BL_DataMisoTemp: std_logic_vector((ENT_Leangth -1)downto 0):= (others=> '0');--data chờ truyền
		signal BL_DataMisoEmptyFlag: boolean:= false;-- không có data
		signal BL_DataMisoTempEmptyFlag: boolean:= false;-- không có data
		signal BL_DataMisoEmptyFlagResert: std_logic:= '0';--resert trạng thai của data miso
		signal BL_DataMisoTempEmptyFlagResert: std_logic:= '0';--resert trạng thai của data miso temp
		--DataMosi
		signal BL_DataMosiTemp: std_logic_vector((ENT_Leangth -1)downto 0):= (others=> '0');--data nhận được
		--Error
		signal BL_NSSError: boolean:= false;-- lỗi liên quang đến nss
		signal BL_DataMisoTempError: boolean:= false;-- không có data để truyền
	begin
		BL_CLKIn<= BL_PO_ClkIn when ENT_MODE = false else '0';
		BL_SCK<= BL_PO_SCK when (ENT_MODE = false) and (BL_DeviceStatus = true)else (not BL_nss) when ENT_MODE = false else 'Z';
		BL_mosi<= BL_PO_MOSI when ENT_MODE= false else 'Z';
		BL_PO_MISO<= BL_miso when ENT_MODE = false else 'Z';
		BL_nss<= BL_PO_NSS when ENT_MODE = false else 'Z';
		BL_DataNewEvent<= BL_PO_DataNewEvent when ENT_MODE = false else '0';
		BL_PO_DataReceiveNewEvent<= BL_DataReceiveEvent when ENT_MODE = false else 'Z';
		BL_miso<= BL_DataMiso(BL_DataCount);
		--CountClock
		BL_DataCountClock<= BL_PO_SCK when BL_DataCountEnable = true else '0';
		DataMisoTempControl: process(BL_DataNewEvent, BL_DataMisoTempEmptyFlagResert)is
        begin
			if((BL_DataMisoTempEmptyFlagResert = '1') or (ENT_DeviceResetEvent = '1'))then
				BL_DataMisoTemp<= (others=> '0');
				BL_DataMisoTempEmptyFlag<= false;
			elsif(BL_DataNewEvent'event and BL_DataNewEvent = '1')then
				BL_DataMisoTemp<= BL_PO_DataIn;
				BL_DataMisoTempEmptyFlag<= true;--data temp có data
			end if;
		end process DataMisoTempControl;
		DataMisoControl:process (BL_CLKIn, BL_DataMisoEmptyFlagResert)is
			variable PROC_DataMisoEmptyFlag: boolean:= false;--chưa có data
			variable PROC_DataMiso: std_logic_vector((ENT_Leangth -1)downto 0):= (others=> '0');
        begin
			if((BL_DataMisoEmptyFlagResert = '1') or (ENT_DeviceResetEvent = '1'))then
				PROC_DataMiso:= (others=> '0');
				PROC_DataMisoEmptyFlag:= false;
				BL_DataMiso<=(others=> '0');
			elsif(BL_CLKIn'event and BL_CLKIn = '1')then
				if(BL_DeviceStatus = true)then--Device đã hoạt động
					if((BL_DataMisoTempEmptyFlag = true) and (PROC_DataMisoEmptyFlag = false))then--data temp có data
						PROC_DataMiso:= BL_DataMisoTemp;
						BL_DataMiso<=PROC_DataMiso;
						BL_DataMisoTempEmptyFlagResert<= '1';
					else
						PROC_DataMiso:= BL_DataMiso;
						BL_DataMiso<=PROC_DataMiso;
						BL_DataMisoTempEmptyFlagResert<= '0';
					end if;
				else
					PROC_DataMiso:= BL_DataMiso;
					BL_DataMiso<=PROC_DataMiso;
					BL_DataMisoTempEmptyFlagResert<= '0';
				end if;
				
			end if;
		end process DataMisoControl;
		DataCount:process(BL_DataCountClock)is
			variable PROC_DataCount: integer range (ENT_Leangth -1)downto 0:= (ENT_Leangth -1);
        begin
			if(ENT_DeviceResetEvent = '1') then
				PROC_DataCount:= ENT_Leangth -1;
			elsif((BL_DataCountClock'event and BL_DataCountClock = '0') and (BL_DeviceStatus = true))then
				if(PROC_DataCount = 0)then
					PROC_DataCount:= (ENT_Leangth -1);--resert datacount
					BL_DataCount<= PROC_DataCount;
				else
					PROC_DataCount:= PROC_DataCount -1;
					BL_DataCount<= PROC_DataCount;
				end if;
			end if;
		end process DataCount;
		DeviceStatus:process(BL_nss)is
			variable PROC_DeviceStatus: boolean:= false;
			variable PROC_NSSError: boolean:= false;
		begin
			if((BL_nss = '1') or (ENT_DeviceResetEvent = '1'))then
				BL_DataCountEnable<= false;-- không cho phép đếm data
				PROC_NSSError:= false;
				BL_NSSError<= PROC_NSSError;
			elsif(BL_nss'event and BL_nss = '0')then
				BL_DataCountEnable<= true;--cho phép đếm data
				if(PROC_DeviceStatus = true)then
					--lỗi
					PROC_NSSError:= true;-- lỗi nss
					BL_NSSError<= PROC_NSSError;
					BL_DeviceStatus<= false;--tắt device
				else
				
					PROC_NSSError:= BL_NSSError;
					BL_NSSError<= PROC_NSSError;
					BL_DeviceStatus<= true;--bật device
				end if;
			end if;
		end process DeviceStatus;
		GetDataMosi:process(BL_SCK)is
			variable PROC_DataMosi: std_logic_vector((ENT_Leangth -1) downto 0):= (others=> '0');
			variable PROC_DataMosiTemp: std_logic_vector((ENT_Leangth -1) downto 0):= (others=> '0');
        begin
			if(BL_SCK'event and BL_SCK = '1')then
				PROC_DataMosi(BL_DataCount):= BL_PO_MOSI;
				if(BL_DataCount = 0)then
					PROC_DataMosiTemp:= PROC_DataMosi;
					BL_DataMosiTemp<= PROC_DataMosiTemp;
				else
					PROC_DataMosiTemp:= BL_DataMosiTemp;
					BL_DataMosiTemp<= PROC_DataMosiTemp;
				end if;
			end if;
		end process GetDataMosi;
		OutDataMiso:process(BL_SCK)is
			variable PROC_EndData: boolean:= false;--xác định xem data có phài là cuối cùng hai chỉ mới bắt đầu
        begin
			if(BL_SCK'event and BL_SCK = '0')then
				if((BL_DataCount = 1) and (PROC_EndData = false))then
					BL_DataMisoEmptyFlagResert<= '0';
					BL_DataReceiveEvent<= '0';
					PROC_EndData:= true;
				elsif((BL_DataCount = 0) and (PROC_EndData = true))then
					BL_DataMisoEmptyFlagResert<= '1';--resert data miso
					BL_DataReceiveEvent<= '1';--data receive event
					PROC_EndData:= false;
				else
					BL_DataMisoEmptyFlagResert<= '0';
					BL_DataReceiveEvent<= '0';
					PROC_EndData:= false;
				end if;
			end if;
		end process;
	end block Slave;
end architecture SPI_Protocol_Behavioral;