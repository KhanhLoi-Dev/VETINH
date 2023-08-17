library ieee;
use ieee.std_logic_1164.all;
library std;
use std.textio.all;	
library work;
use work.KL_Simulator.all;
entity YourEntity is
  port (
    clk      : in  std_logic;
    signalA  : out std_logic
  );
end entity YourEntity;

architecture Behavioral of YourEntity is
  component SPI_Slave is
	generic(ENT_Leangth: integer:= 16;
			ENT_CRCEnable: boolean:= false;--bật CRC Check
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
end component SPI_Slave;
  file CSDL: text;
  shared variable PROC_Line: line;
  signal ARC_SCK: std_logic:= '0';
  signal ARC_MISO: std_logic;
  signal ARC_MOSI: std_logic;
  signal ARC_NSS: std_logic:= '1';
  signal ARC_CRC: std_logic:= '0';
  signal ARC_RESET: std_logic:= '0';
  signal ARC_dataout: std_logic_vector(7 downto 0);
  signal ARC_newevent: std_logic:= '0';
  shared variable PROC_DataLine: string(1 to 50);
begin
   file_open(CSDL, "test_spi.csv",read_mode);
  readline(CSDL, PROC_Line);
  readline(CSDL, PROC_Line); 
  read(PROC_Line, PROC_DataLine);
  process(clk)is
	  variable PROC_lengthLine: integer;
    variable PROC_Time_inte: integer:= 0;
    variable PROC_Time_time: time:=0 fs;
    variable PROC_SCK: std_logic:= '0';
    variable PROC_MISO: std_logic:= '0';
    variable PROC_MOSI: std_logic:= '0';
    variable PROC_NSS: std_logic:= '1';
    variable PROC_CRC: std_logic:= '0';
    variable PROC_Resert: std_logic:= '0';--tín hiệu resert
    variable PROC_DataNewEvent: std_logic:= '0';
    variable PROC_DataOut: std_logic_vector(7 downto 0);
    variable PROC_TimeCurrent: time;
  begin	
    if not endfile(CSDL) then
      PROC_TimeCurrent:= now;
      KL_GetDataCell(1, 20, PROC_DataLine, PROC_Time_inte);--lấy thời gian (time)
      PROC_Time_time:= time'val(PROC_Time_inte);
      if(PROC_Time_time = PROC_TimeCurrent)then
        KL_GetDataCell(22, PROC_DataLine, PROC_SCK);--lấy CSK
        KL_GetDataCell(24, PROC_DataLine, PROC_MISO);--lấy miso
        KL_GetDataCell(26, PROC_DataLine, PROC_MOSI);--lấy mosi
        KL_GetDataCell(28, PROC_DataLine, PROC_NSS);--lấy NSS
        KL_GetDataCell(30, PROC_DataLine, PROC_DataNewEvent);--lấy PROC_DataNewEvent
        KL_GetDataCell(32, PROC_DataLine, PROC_CRC);--lấy miso
        KL_GetDataCell(34, PROC_DataLine, PROC_Resert);--lấy reset
        KL_GetDataCell(36, 8, PROC_DataLine, PROC_DataOut);--lấy DATA
        readline(CSDL, PROC_Line);
        read(PROC_Line, PROC_DataLine);
      end if;
    end if;
    ARC_SCK<= PROC_SCK;
    --ARC_MISO<= PROC_MISO;
    ARC_mosi<= PROC_mosi;
    ARC_NSS<= PROC_NSS;
    ARC_newevent<= PROC_DataNewEvent;
    ARC_dataout<= PROC_DataOut;
    ARC_RESET<= PROC_Resert;
    ARC_CRC<= PROC_CRC;
  end process;
  spi_slave_a: spi_slave generic map(ENT_Leangth=>8, ENT_CRCEnable=> true) 
                          PORT map(ENT_DataIn=> ARC_dataout,
                                  ENT_ClkIn=>CLK,
                                  ENT_SCK=> ARC_SCK,
                                  ENT_DataNewEvent=> ARC_newevent,
                                  ENT_MOSI=>ARC_MOSI,
                                  ENT_MISO=> ARC_MISO,
                                  ent_nss=>ARC_NSS,
                                  ENT_DataEmpty=> open,
                                  ENT_CRCEvent=> ARC_CRC,
                                  ENT_DeviceResetEvent=> ARC_RESET);
end architecture Behavioral; 
