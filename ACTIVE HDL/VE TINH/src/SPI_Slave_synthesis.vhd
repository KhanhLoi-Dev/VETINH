--------------------------------------------------------------------------------
-- Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /    Vendor: Xilinx
-- \   \   \/     Version: P.20131013
--  \   \         Application: netgen
--  /   /         Filename: SPI_Slave_synthesis.vhd
-- /___/   /\     Timestamp: Fri Aug 18 09:06:21 2023
-- \   \  /  \ 
--  \___\/\___\
--             
-- Command	: -intstyle ise -ar Structure -tm SPI_Slave -w -dir netgen/synthesis -ofmt vhdl -sim SPI_Slave.ngc SPI_Slave_synthesis.vhd 
-- Device	: xc6slx16-3-ftg256
-- Input file	: SPI_Slave.ngc
-- Output file	: \\123.123.34.102\dsm-congviec\KL-DEV\D\VE_TINH\netgen\synthesis\SPI_Slave_synthesis.vhd
-- # of Entities	: 1
-- Design Name	: SPI_Slave
-- Xilinx	: C:\Xilinx\14.7\ISE_DS\ISE\
--             
-- Purpose:    
--     This VHDL netlist is a verification model and uses simulation 
--     primitives which may not represent the true implementation of the 
--     device, however the netlist is functionally correct and should not 
--     be modified. This file cannot be synthesized and should only be used 
--     with supported simulation tools.
--             
-- Reference:  
--     Command Line Tools User Guide, Chapter 23
--     Synthesis and Simulation Design Guide, Chapter 6
--             
--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
use UNISIM.VPKG.ALL;

entity SPI_Slave_Syn is
  port (
    ENT_ClkIn : in STD_LOGIC := 'X'; 
    ENT_DataNewEvent : in STD_LOGIC := 'X'; 
    ENT_SCK : in STD_LOGIC := 'X'; 
    ENT_MOSI : in STD_LOGIC := 'X'; 
    ENT_NSS : in STD_LOGIC := 'X'; 
    ENT_DeviceResetEvent : in STD_LOGIC := 'X'; 
    ENT_CRCEvent : in STD_LOGIC := 'X'; 
    ENT_MISO : out STD_LOGIC; 
    ENT_DataEmpty : out STD_LOGIC; 
    ENT_DataReceiveEvent : out STD_LOGIC; 
    ENT_DataIn : in STD_LOGIC_VECTOR ( 7 downto 0 ); 
    ENT_DataOut : out STD_LOGIC_VECTOR ( 7 downto 0 ); 
    ENT_Error : out STD_LOGIC_VECTOR ( 2 downto 0 ) 
  );
end SPI_Slave_Syn;

architecture Structure of SPI_Slave_Syn is
  signal ENT_DataIn_7_IBUF_0 : STD_LOGIC; 
  signal ENT_DataIn_6_IBUF_1 : STD_LOGIC; 
  signal ENT_DataIn_5_IBUF_2 : STD_LOGIC; 
  signal ENT_DataIn_4_IBUF_3 : STD_LOGIC; 
  signal ENT_DataIn_3_IBUF_4 : STD_LOGIC; 
  signal ENT_DataIn_2_IBUF_5 : STD_LOGIC; 
  signal ENT_DataIn_1_IBUF_6 : STD_LOGIC; 
  signal ENT_DataIn_0_IBUF_7 : STD_LOGIC; 
  signal ENT_ClkIn_BUFGP_8 : STD_LOGIC; 
  signal ENT_DataNewEvent_BUFGP_9 : STD_LOGIC; 
  signal ENT_SCK_BUFGP_10 : STD_LOGIC; 
  signal ENT_MOSI_IBUF_11 : STD_LOGIC; 
  signal ENT_NSS_IBUF_BUFG_12 : STD_LOGIC; 
  signal ENT_DeviceResetEvent_IBUF_13 : STD_LOGIC; 
  signal ENT_CRCEvent_BUFGP_14 : STD_LOGIC; 
  signal ARC_CRCStartReset_23 : STD_LOGIC; 
  signal ARC_DataMisoTempEmptyReset_24 : STD_LOGIC; 
  signal ARC_CRCDataInputCompute_25 : STD_LOGIC; 
  signal ARC_CRCDataNewEventReset_26 : STD_LOGIC; 
  signal ARC_CRCStart_27 : STD_LOGIC; 
  signal DataMisoControl_PROC_DataMisoEmptyFlag_28 : STD_LOGIC; 
  signal DataMisoControl_PROC_DataTransmitEnd_37 : STD_LOGIC; 
  signal ARC_CounterSCKEventReset_38 : STD_LOGIC; 
  signal ARC_DataFrameComputer_39 : STD_LOGIC; 
  signal CRC_DataInput_PROC_DataOne_51 : STD_LOGIC; 
  signal ARC_CRCDataMosiCheckAccess_52 : STD_LOGIC; 
  signal ARC_DataMisoReset_53 : STD_LOGIC; 
  signal ARC_DataMisoTempEmptyFlag_54 : STD_LOGIC; 
  signal ARC_DataMisoTempError_55 : STD_LOGIC; 
  signal ARC_DataMosiEmptyReset_56 : STD_LOGIC; 
  signal ARC_CounterSCKEvent_57 : STD_LOGIC; 
  signal ARC_DataMosiEmptySet_66 : STD_LOGIC; 
  signal GetDataMosi_PROC_DataMosi_7_ENT_MOSI_MUX_45_o : STD_LOGIC; 
  signal GetDataMosi_PROC_DataMosi_6_ENT_MOSI_MUX_46_o : STD_LOGIC; 
  signal GetDataMosi_PROC_DataMosi_5_ENT_MOSI_MUX_47_o : STD_LOGIC; 
  signal GetDataMosi_PROC_DataMosi_4_ENT_MOSI_MUX_48_o : STD_LOGIC; 
  signal GetDataMosi_PROC_DataMosi_3_ENT_MOSI_MUX_49_o : STD_LOGIC; 
  signal GetDataMosi_PROC_DataMosi_2_ENT_MOSI_MUX_50_o : STD_LOGIC; 
  signal GetDataMosi_PROC_DataMosi_1_ENT_MOSI_MUX_51_o : STD_LOGIC; 
  signal GetDataMosi_PROC_DataMosi_0_ENT_MOSI_MUX_52_o : STD_LOGIC; 
  signal ENT_NSS_ENT_DeviceResetEvent_OR_8_o : STD_LOGIC; 
  signal ARC_NSSErrorHighNSS_76 : STD_LOGIC; 
  signal ARC_DeviceStatus_77 : STD_LOGIC; 
  signal ARC_NSSErrorLowNSS_78 : STD_LOGIC; 
  signal ENT_DeviceResetEvent_ARC_DataMisoTempEmptyReset_OR_2_o : STD_LOGIC; 
  signal ENT_DeviceResetEvent_ARC_DataMisoReset_OR_5_o : STD_LOGIC; 
  signal ENT_DeviceResetEvent_ARC_DeviceStatus_AND_10_o : STD_LOGIC; 
  signal ENT_DeviceResetEvent_ARC_DeviceStatus_OR_17_o : STD_LOGIC; 
  signal ARC_CRCDataNewEventReset_ENT_DeviceResetEvent_OR_16_o : STD_LOGIC; 
  signal ARC_CRCStartReset_ENT_DeviceResetEvent_OR_4_o : STD_LOGIC; 
  signal ARC_DataMosiEmptyReset_ENT_DeviceResetEvent_OR_12_o : STD_LOGIC; 
  signal ARC_CounterSCKEventReset_ENT_DeviceResetEvent_OR_10_o : STD_LOGIC; 
  signal ARC_CRCEvent_87 : STD_LOGIC; 
  signal ARC_DataMiso_7_ARC_DataMisoTemp_7_mux_6_OUT_7_Q : STD_LOGIC; 
  signal ARC_DataMiso_7_ARC_DataMisoTemp_7_mux_6_OUT_6_Q : STD_LOGIC; 
  signal ARC_DataMiso_7_ARC_DataMisoTemp_7_mux_6_OUT_5_Q : STD_LOGIC; 
  signal ARC_DataMiso_7_ARC_DataMisoTemp_7_mux_6_OUT_4_Q : STD_LOGIC; 
  signal ARC_DataMiso_7_ARC_DataMisoTemp_7_mux_6_OUT_3_Q : STD_LOGIC; 
  signal ARC_DataMiso_7_ARC_DataMisoTemp_7_mux_6_OUT_2_Q : STD_LOGIC; 
  signal ARC_DataMiso_7_ARC_DataMisoTemp_7_mux_6_OUT_1_Q : STD_LOGIC; 
  signal ARC_DataMiso_7_ARC_DataMisoTemp_7_mux_6_OUT_0_Q : STD_LOGIC; 
  signal ARC_CRCDataNewEventFlag_104 : STD_LOGIC; 
  signal ARC_Counter_2_GND_4_o_mux_14_OUT_2_Q : STD_LOGIC; 
  signal ARC_Counter_2_GND_4_o_mux_14_OUT_1_Q : STD_LOGIC; 
  signal ARC_Counter_2_GND_4_o_mux_14_OUT_0_Q : STD_LOGIC; 
  signal ARC_CRCDataOutput_7_ARC_CRCDataOutput_7_mux_108_OUT_2_Q : STD_LOGIC; 
  signal ARC_CRCCheckError_109 : STD_LOGIC; 
  signal ARC_CRCEvent_ARC_DataMisoEmptyFlag_AND_2_o : STD_LOGIC; 
  signal ARC_CRCDataMosiComputer_7_INV_76_o : STD_LOGIC; 
  signal ARC_DataReceiveEvent_120 : STD_LOGIC; 
  signal ENT_DeviceResetEvent_ARC_DeviceStatus_OR_14_o : STD_LOGIC; 
  signal ENT_Error_2_OBUF_122 : STD_LOGIC; 
  signal ARC_DeviceStatus_ARC_CRCDataMosiComputerEvent_AND_26_o : STD_LOGIC; 
  signal GND_4_o_GND_4_o_MUX_54_o : STD_LOGIC; 
  signal GND_4_o_ARC_CRCEvent_MUX_24_o : STD_LOGIC; 
  signal DataMisoControl_PROC_DataTransmitEnd_ARC_CRCEvent_MUX_26_o : STD_LOGIC; 
  signal ARC_DataFrameComputer_PWR_4_o_MUX_23_o : STD_LOGIC; 
  signal ARC_CRCDataMosiComputerEvent_128 : STD_LOGIC; 
  signal ENT_MISO_OBUF_129 : STD_LOGIC; 
  signal ARC_Counter_2_Decoder_21_OUT_7_Q : STD_LOGIC; 
  signal ARC_Counter_2_Decoder_21_OUT_0_Q : STD_LOGIC; 
  signal N0 : STD_LOGIC; 
  signal N1 : STD_LOGIC; 
  signal Q_n0653_inv : STD_LOGIC; 
  signal Q_n0675_inv : STD_LOGIC; 
  signal Mmux_ENT_MISO_4_151 : STD_LOGIC; 
  signal Mmux_ENT_MISO_3_152 : STD_LOGIC; 
  signal ARC_CRCDataMosiComputer_7_INV_76_o1_153 : STD_LOGIC; 
  signal ARC_CRCDataMosiComputer_7_INV_76_o2_154 : STD_LOGIC; 
  signal ARC_CRCDataMosiComputer_7_INV_76_o3_155 : STD_LOGIC; 
  signal ARC_CRCDataMosiComputerEvent_glue_set_185 : STD_LOGIC; 
  signal ARC_DeviceStatus_rstpot_186 : STD_LOGIC; 
  signal ARC_NSSErrorLowNSS_rstpot_187 : STD_LOGIC; 
  signal ARC_DataMisoTempError_rstpot_188 : STD_LOGIC; 
  signal ARC_DataFrameComputer_rstpot_189 : STD_LOGIC; 
  signal CRC_DataInput_PROC_DataOne_rstpot_190 : STD_LOGIC; 
  signal ARC_DataMisoReset_rstpot1_191 : STD_LOGIC; 
  signal ARC_DeviceStatus_1_192 : STD_LOGIC; 
  signal ENT_NSS_IBUF_193 : STD_LOGIC; 
  signal ARC_DataMosiTemp_7_1_194 : STD_LOGIC; 
  signal ARC_DataMosiTemp_6_1_195 : STD_LOGIC; 
  signal ARC_DataMosiTemp_5_1_196 : STD_LOGIC; 
  signal ARC_DataMosiTemp_4_1_197 : STD_LOGIC; 
  signal ARC_DataMosiTemp_3_1_198 : STD_LOGIC; 
  signal ARC_DataMosiTemp_2_1_199 : STD_LOGIC; 
  signal ARC_DataMosiTemp_1_1_200 : STD_LOGIC; 
  signal ARC_DataMosiTemp_0_1_201 : STD_LOGIC; 
  signal ARC_DataMisoTempEmptyFlag_1_202 : STD_LOGIC; 
  signal ARC_DataReceiveEvent_1_203 : STD_LOGIC; 
  signal ARC_DataMisoTemp : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal ARC_DataMiso : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal ARC_Counter : STD_LOGIC_VECTOR ( 2 downto 0 ); 
  signal ARC_CRCDataOutput : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal GetDataMosi_PROC_DataMosi : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal ARC_CRCDataMosiComputer : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal ARC_DataMosiTemp : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal Q_n0633 : STD_LOGIC_VECTOR ( 9 downto 9 ); 
  signal n0358 : STD_LOGIC_VECTOR ( 9 downto 9 ); 
  signal n0437 : STD_LOGIC_VECTOR ( 9 downto 9 ); 
  signal n0361 : STD_LOGIC_VECTOR ( 9 downto 9 ); 
  signal n0440 : STD_LOGIC_VECTOR ( 9 downto 9 ); 
  signal n0364 : STD_LOGIC_VECTOR ( 9 downto 9 ); 
  signal n0443 : STD_LOGIC_VECTOR ( 9 downto 9 ); 
  signal n0367 : STD_LOGIC_VECTOR ( 9 downto 9 ); 
  signal n0446 : STD_LOGIC_VECTOR ( 9 downto 9 ); 
  signal n0370 : STD_LOGIC_VECTOR ( 9 downto 9 ); 
  signal n0449 : STD_LOGIC_VECTOR ( 9 downto 9 ); 
  signal n0373 : STD_LOGIC_VECTOR ( 9 downto 9 ); 
  signal n0452 : STD_LOGIC_VECTOR ( 9 downto 9 ); 
  signal n0376 : STD_LOGIC_VECTOR ( 9 downto 9 ); 
  signal n0455 : STD_LOGIC_VECTOR ( 9 downto 9 ); 
begin
  XST_VCC : VCC
    port map (
      P => N0
    );
  XST_GND : GND
    port map (
      G => N1
    );
  ARC_DataMisoTemp_0 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => ENT_DataNewEvent_BUFGP_9,
      CLR => ENT_DeviceResetEvent_ARC_DataMisoTempEmptyReset_OR_2_o,
      D => ENT_DataIn_0_IBUF_7,
      Q => ARC_DataMisoTemp(0)
    );
  ARC_DataMisoTemp_1 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => ENT_DataNewEvent_BUFGP_9,
      CLR => ENT_DeviceResetEvent_ARC_DataMisoTempEmptyReset_OR_2_o,
      D => ENT_DataIn_1_IBUF_6,
      Q => ARC_DataMisoTemp(1)
    );
  ARC_DataMisoTemp_2 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => ENT_DataNewEvent_BUFGP_9,
      CLR => ENT_DeviceResetEvent_ARC_DataMisoTempEmptyReset_OR_2_o,
      D => ENT_DataIn_2_IBUF_5,
      Q => ARC_DataMisoTemp(2)
    );
  ARC_DataMisoTemp_3 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => ENT_DataNewEvent_BUFGP_9,
      CLR => ENT_DeviceResetEvent_ARC_DataMisoTempEmptyReset_OR_2_o,
      D => ENT_DataIn_3_IBUF_4,
      Q => ARC_DataMisoTemp(3)
    );
  ARC_DataMisoTemp_4 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => ENT_DataNewEvent_BUFGP_9,
      CLR => ENT_DeviceResetEvent_ARC_DataMisoTempEmptyReset_OR_2_o,
      D => ENT_DataIn_4_IBUF_3,
      Q => ARC_DataMisoTemp(4)
    );
  ARC_DataMisoTemp_5 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => ENT_DataNewEvent_BUFGP_9,
      CLR => ENT_DeviceResetEvent_ARC_DataMisoTempEmptyReset_OR_2_o,
      D => ENT_DataIn_5_IBUF_2,
      Q => ARC_DataMisoTemp(5)
    );
  ARC_DataMisoTemp_6 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => ENT_DataNewEvent_BUFGP_9,
      CLR => ENT_DeviceResetEvent_ARC_DataMisoTempEmptyReset_OR_2_o,
      D => ENT_DataIn_6_IBUF_1,
      Q => ARC_DataMisoTemp(6)
    );
  ARC_DataMisoTemp_7 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => ENT_DataNewEvent_BUFGP_9,
      CLR => ENT_DeviceResetEvent_ARC_DataMisoTempEmptyReset_OR_2_o,
      D => ENT_DataIn_7_IBUF_0,
      Q => ARC_DataMisoTemp(7)
    );
  ARC_CRCStartReset : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => ENT_ClkIn_BUFGP_8,
      D => ENT_NSS_IBUF_193,
      Q => ARC_CRCStartReset_23
    );
  DataMisoControl_PROC_DataMisoEmptyFlag : FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => ENT_ClkIn_BUFGP_8,
      CE => ARC_DataFrameComputer_PWR_4_o_MUX_23_o,
      D => N1,
      PRE => ENT_DeviceResetEvent_ARC_DataMisoReset_OR_5_o,
      Q => DataMisoControl_PROC_DataMisoEmptyFlag_28
    );
  ARC_CRCStart : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => ENT_ClkIn_BUFGP_8,
      CE => ARC_CRCEvent_ARC_DataMisoEmptyFlag_AND_2_o,
      CLR => ARC_CRCStartReset_ENT_DeviceResetEvent_OR_4_o,
      D => N0,
      Q => ARC_CRCStart_27
    );
  ARC_CRCDataMosiCheckAccess : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => ENT_ClkIn_BUFGP_8,
      CE => ARC_DeviceStatus_ARC_CRCDataMosiComputerEvent_AND_26_o,
      CLR => ENT_DeviceResetEvent_ARC_DeviceStatus_OR_17_o,
      D => N0,
      Q => ARC_CRCDataMosiCheckAccess_52
    );
  ARC_DataMisoTempEmptyFlag : FDP
    generic map(
      INIT => '1'
    )
    port map (
      C => ENT_DataNewEvent_BUFGP_9,
      D => N1,
      PRE => ENT_DeviceResetEvent_ARC_DataMisoTempEmptyReset_OR_2_o,
      Q => ARC_DataMisoTempEmptyFlag_54
    );
  ARC_NSSErrorHighNSS : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => ENT_NSS_IBUF_BUFG_12,
      CE => Q_n0653_inv,
      CLR => ENT_DeviceResetEvent_ARC_DeviceStatus_AND_10_o,
      D => N0,
      Q => ARC_NSSErrorHighNSS_76
    );
  ARC_CRCEvent : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => ENT_CRCEvent_BUFGP_14,
      CLR => ENT_DeviceResetEvent_ARC_DeviceStatus_OR_17_o,
      D => N0,
      Q => ARC_CRCEvent_87
    );
  ARC_DataMisoTempEmptyReset : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => ENT_ClkIn_BUFGP_8,
      CLR => ENT_DeviceResetEvent_ARC_DataMisoReset_OR_5_o,
      D => ARC_DataFrameComputer_PWR_4_o_MUX_23_o,
      Q => ARC_DataMisoTempEmptyReset_24
    );
  ARC_Counter_0 : FDE
    generic map(
      INIT => '1'
    )
    port map (
      C => ENT_ClkIn_BUFGP_8,
      CE => ARC_DeviceStatus_77,
      D => ARC_Counter_2_GND_4_o_mux_14_OUT_0_Q,
      Q => ARC_Counter(0)
    );
  ARC_Counter_1 : FDE
    generic map(
      INIT => '1'
    )
    port map (
      C => ENT_ClkIn_BUFGP_8,
      CE => ARC_DeviceStatus_77,
      D => ARC_Counter_2_GND_4_o_mux_14_OUT_1_Q,
      Q => ARC_Counter(1)
    );
  ARC_Counter_2 : FDE
    generic map(
      INIT => '1'
    )
    port map (
      C => ENT_ClkIn_BUFGP_8,
      CE => ARC_DeviceStatus_77,
      D => ARC_Counter_2_GND_4_o_mux_14_OUT_2_Q,
      Q => ARC_Counter(2)
    );
  GetDataMosi_PROC_DataMosi_0 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => ENT_SCK_BUFGP_10,
      CE => ARC_DeviceStatus_77,
      CLR => ENT_DeviceResetEvent_ARC_DeviceStatus_OR_14_o,
      D => GetDataMosi_PROC_DataMosi_0_ENT_MOSI_MUX_52_o,
      Q => GetDataMosi_PROC_DataMosi(0)
    );
  GetDataMosi_PROC_DataMosi_1 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => ENT_SCK_BUFGP_10,
      CE => ARC_DeviceStatus_77,
      CLR => ENT_DeviceResetEvent_ARC_DeviceStatus_OR_14_o,
      D => GetDataMosi_PROC_DataMosi_1_ENT_MOSI_MUX_51_o,
      Q => GetDataMosi_PROC_DataMosi(1)
    );
  GetDataMosi_PROC_DataMosi_2 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => ENT_SCK_BUFGP_10,
      CE => ARC_DeviceStatus_77,
      CLR => ENT_DeviceResetEvent_ARC_DeviceStatus_OR_14_o,
      D => GetDataMosi_PROC_DataMosi_2_ENT_MOSI_MUX_50_o,
      Q => GetDataMosi_PROC_DataMosi(2)
    );
  GetDataMosi_PROC_DataMosi_3 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => ENT_SCK_BUFGP_10,
      CE => ARC_DeviceStatus_77,
      CLR => ENT_DeviceResetEvent_ARC_DeviceStatus_OR_14_o,
      D => GetDataMosi_PROC_DataMosi_3_ENT_MOSI_MUX_49_o,
      Q => GetDataMosi_PROC_DataMosi(3)
    );
  GetDataMosi_PROC_DataMosi_4 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => ENT_SCK_BUFGP_10,
      CE => ARC_DeviceStatus_77,
      CLR => ENT_DeviceResetEvent_ARC_DeviceStatus_OR_14_o,
      D => GetDataMosi_PROC_DataMosi_4_ENT_MOSI_MUX_48_o,
      Q => GetDataMosi_PROC_DataMosi(4)
    );
  GetDataMosi_PROC_DataMosi_5 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => ENT_SCK_BUFGP_10,
      CE => ARC_DeviceStatus_77,
      CLR => ENT_DeviceResetEvent_ARC_DeviceStatus_OR_14_o,
      D => GetDataMosi_PROC_DataMosi_5_ENT_MOSI_MUX_47_o,
      Q => GetDataMosi_PROC_DataMosi(5)
    );
  GetDataMosi_PROC_DataMosi_6 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => ENT_SCK_BUFGP_10,
      CE => ARC_DeviceStatus_77,
      CLR => ENT_DeviceResetEvent_ARC_DeviceStatus_OR_14_o,
      D => GetDataMosi_PROC_DataMosi_6_ENT_MOSI_MUX_46_o,
      Q => GetDataMosi_PROC_DataMosi(6)
    );
  GetDataMosi_PROC_DataMosi_7 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => ENT_SCK_BUFGP_10,
      CE => ARC_DeviceStatus_77,
      CLR => ENT_DeviceResetEvent_ARC_DeviceStatus_OR_14_o,
      D => GetDataMosi_PROC_DataMosi_7_ENT_MOSI_MUX_45_o,
      Q => GetDataMosi_PROC_DataMosi(7)
    );
  ARC_CounterSCKEvent : FDCE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => ENT_SCK_BUFGP_10,
      CE => ARC_DeviceStatus_77,
      CLR => ARC_CounterSCKEventReset_ENT_DeviceResetEvent_OR_10_o,
      D => N0,
      Q => ARC_CounterSCKEvent_57
    );
  ARC_DataMosiEmptySet : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => ENT_SCK_BUFGP_10,
      CE => ARC_DeviceStatus_77,
      CLR => ENT_DeviceResetEvent_ARC_DeviceStatus_OR_14_o,
      D => ARC_Counter_2_Decoder_21_OUT_0_Q,
      Q => ARC_DataMosiEmptySet_66
    );
  ARC_CRCDataNewEventFlag : FDC_1
    generic map(
      INIT => '0'
    )
    port map (
      C => DataMisoControl_PROC_DataMisoEmptyFlag_28,
      CLR => ARC_CRCDataNewEventReset_ENT_DeviceResetEvent_OR_16_o,
      D => N0,
      Q => ARC_CRCDataNewEventFlag_104
    );
  ARC_CRCDataInputCompute : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => ENT_ClkIn_BUFGP_8,
      CLR => ENT_DeviceResetEvent_ARC_DataMisoReset_OR_5_o,
      D => GND_4_o_ARC_CRCEvent_MUX_24_o,
      Q => ARC_CRCDataInputCompute_25
    );
  ARC_CRCDataNewEventReset : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => ENT_ClkIn_BUFGP_8,
      D => ARC_CRCDataNewEventFlag_104,
      Q => ARC_CRCDataNewEventReset_26
    );
  ARC_CounterSCKEventReset : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => ENT_ClkIn_BUFGP_8,
      CE => ARC_DeviceStatus_77,
      D => ARC_CounterSCKEvent_57,
      Q => ARC_CounterSCKEventReset_38
    );
  DataMisoControl_PROC_DataTransmitEnd : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => ENT_ClkIn_BUFGP_8,
      CE => ARC_DataFrameComputer_PWR_4_o_MUX_23_o,
      CLR => ENT_DeviceResetEvent_ARC_DataMisoReset_OR_5_o,
      D => DataMisoControl_PROC_DataTransmitEnd_ARC_CRCEvent_MUX_26_o,
      Q => DataMisoControl_PROC_DataTransmitEnd_37
    );
  ARC_DataMosiEmptyReset : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => ENT_SCK_BUFGP_10,
      CLR => ENT_DeviceResetEvent_ARC_DeviceStatus_OR_14_o,
      D => GND_4_o_GND_4_o_MUX_54_o,
      Q => ARC_DataMosiEmptyReset_56
    );
  ARC_DataMosiTemp_0 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => ARC_DataMosiEmptySet_66,
      D => GetDataMosi_PROC_DataMosi(0),
      Q => ARC_DataMosiTemp(0)
    );
  ARC_DataMosiTemp_1 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => ARC_DataMosiEmptySet_66,
      D => GetDataMosi_PROC_DataMosi(1),
      Q => ARC_DataMosiTemp(1)
    );
  ARC_DataMosiTemp_2 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => ARC_DataMosiEmptySet_66,
      D => GetDataMosi_PROC_DataMosi(2),
      Q => ARC_DataMosiTemp(2)
    );
  ARC_DataMosiTemp_3 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => ARC_DataMosiEmptySet_66,
      D => GetDataMosi_PROC_DataMosi(3),
      Q => ARC_DataMosiTemp(3)
    );
  ARC_DataMosiTemp_4 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => ARC_DataMosiEmptySet_66,
      D => GetDataMosi_PROC_DataMosi(4),
      Q => ARC_DataMosiTemp(4)
    );
  ARC_DataMosiTemp_5 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => ARC_DataMosiEmptySet_66,
      D => GetDataMosi_PROC_DataMosi(5),
      Q => ARC_DataMosiTemp(5)
    );
  ARC_DataMosiTemp_6 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => ARC_DataMosiEmptySet_66,
      D => GetDataMosi_PROC_DataMosi(6),
      Q => ARC_DataMosiTemp(6)
    );
  ARC_DataMosiTemp_7 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => ARC_DataMosiEmptySet_66,
      D => GetDataMosi_PROC_DataMosi(7),
      Q => ARC_DataMosiTemp(7)
    );
  ARC_DataReceiveEvent : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => ARC_DataMosiEmptySet_66,
      CLR => ARC_DataMosiEmptyReset_ENT_DeviceResetEvent_OR_12_o,
      D => N0,
      Q => ARC_DataReceiveEvent_120
    );
  ARC_CRCDataOutput_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => ENT_ClkIn_BUFGP_8,
      CE => Q_n0675_inv,
      D => n0361(9),
      Q => ARC_CRCDataOutput(0)
    );
  ARC_CRCDataOutput_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => ENT_ClkIn_BUFGP_8,
      CE => Q_n0675_inv,
      D => n0358(9),
      Q => ARC_CRCDataOutput(1)
    );
  ARC_CRCDataOutput_2 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => ENT_ClkIn_BUFGP_8,
      CE => Q_n0675_inv,
      D => ARC_CRCDataOutput_7_ARC_CRCDataOutput_7_mux_108_OUT_2_Q,
      Q => ARC_CRCDataOutput(2)
    );
  ARC_CRCDataOutput_3 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => ENT_ClkIn_BUFGP_8,
      CE => Q_n0675_inv,
      D => n0376(9),
      Q => ARC_CRCDataOutput(3)
    );
  ARC_CRCDataOutput_4 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => ENT_ClkIn_BUFGP_8,
      CE => Q_n0675_inv,
      D => n0373(9),
      Q => ARC_CRCDataOutput(4)
    );
  ARC_CRCDataOutput_5 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => ENT_ClkIn_BUFGP_8,
      CE => Q_n0675_inv,
      D => n0370(9),
      Q => ARC_CRCDataOutput(5)
    );
  ARC_CRCDataOutput_6 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => ENT_ClkIn_BUFGP_8,
      CE => Q_n0675_inv,
      D => n0367(9),
      Q => ARC_CRCDataOutput(6)
    );
  ARC_CRCDataOutput_7 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => ENT_ClkIn_BUFGP_8,
      CE => Q_n0675_inv,
      D => n0364(9),
      Q => ARC_CRCDataOutput(7)
    );
  ARC_DataMiso_0 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => ENT_ClkIn_BUFGP_8,
      CE => ARC_DataFrameComputer_PWR_4_o_MUX_23_o,
      CLR => ENT_DeviceResetEvent_ARC_DataMisoReset_OR_5_o,
      D => ARC_DataMiso_7_ARC_DataMisoTemp_7_mux_6_OUT_0_Q,
      Q => ARC_DataMiso(0)
    );
  ARC_DataMiso_1 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => ENT_ClkIn_BUFGP_8,
      CE => ARC_DataFrameComputer_PWR_4_o_MUX_23_o,
      CLR => ENT_DeviceResetEvent_ARC_DataMisoReset_OR_5_o,
      D => ARC_DataMiso_7_ARC_DataMisoTemp_7_mux_6_OUT_1_Q,
      Q => ARC_DataMiso(1)
    );
  ARC_DataMiso_2 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => ENT_ClkIn_BUFGP_8,
      CE => ARC_DataFrameComputer_PWR_4_o_MUX_23_o,
      CLR => ENT_DeviceResetEvent_ARC_DataMisoReset_OR_5_o,
      D => ARC_DataMiso_7_ARC_DataMisoTemp_7_mux_6_OUT_2_Q,
      Q => ARC_DataMiso(2)
    );
  ARC_DataMiso_3 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => ENT_ClkIn_BUFGP_8,
      CE => ARC_DataFrameComputer_PWR_4_o_MUX_23_o,
      CLR => ENT_DeviceResetEvent_ARC_DataMisoReset_OR_5_o,
      D => ARC_DataMiso_7_ARC_DataMisoTemp_7_mux_6_OUT_3_Q,
      Q => ARC_DataMiso(3)
    );
  ARC_DataMiso_4 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => ENT_ClkIn_BUFGP_8,
      CE => ARC_DataFrameComputer_PWR_4_o_MUX_23_o,
      CLR => ENT_DeviceResetEvent_ARC_DataMisoReset_OR_5_o,
      D => ARC_DataMiso_7_ARC_DataMisoTemp_7_mux_6_OUT_4_Q,
      Q => ARC_DataMiso(4)
    );
  ARC_DataMiso_5 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => ENT_ClkIn_BUFGP_8,
      CE => ARC_DataFrameComputer_PWR_4_o_MUX_23_o,
      CLR => ENT_DeviceResetEvent_ARC_DataMisoReset_OR_5_o,
      D => ARC_DataMiso_7_ARC_DataMisoTemp_7_mux_6_OUT_5_Q,
      Q => ARC_DataMiso(5)
    );
  ARC_DataMiso_6 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => ENT_ClkIn_BUFGP_8,
      CE => ARC_DataFrameComputer_PWR_4_o_MUX_23_o,
      CLR => ENT_DeviceResetEvent_ARC_DataMisoReset_OR_5_o,
      D => ARC_DataMiso_7_ARC_DataMisoTemp_7_mux_6_OUT_6_Q,
      Q => ARC_DataMiso(6)
    );
  ARC_DataMiso_7 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => ENT_ClkIn_BUFGP_8,
      CE => ARC_DataFrameComputer_PWR_4_o_MUX_23_o,
      CLR => ENT_DeviceResetEvent_ARC_DataMisoReset_OR_5_o,
      D => ARC_DataMiso_7_ARC_DataMisoTemp_7_mux_6_OUT_7_Q,
      Q => ARC_DataMiso(7)
    );
  ARC_CRCDataMosiComputer_0 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => ARC_DataReceiveEvent_120,
      CE => ARC_CRCStart_27,
      D => n0440(9),
      R => ENT_DeviceResetEvent_ARC_DeviceStatus_OR_17_o,
      Q => ARC_CRCDataMosiComputer(0)
    );
  ARC_CRCDataMosiComputer_1 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => ARC_DataReceiveEvent_120,
      CE => ARC_CRCStart_27,
      D => n0437(9),
      R => ENT_DeviceResetEvent_ARC_DeviceStatus_OR_17_o,
      Q => ARC_CRCDataMosiComputer(1)
    );
  ARC_CRCDataMosiComputer_2 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => ARC_DataReceiveEvent_120,
      CE => ARC_CRCStart_27,
      D => Q_n0633(9),
      R => ENT_DeviceResetEvent_ARC_DeviceStatus_OR_17_o,
      Q => ARC_CRCDataMosiComputer(2)
    );
  ARC_CRCDataMosiComputer_3 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => ARC_DataReceiveEvent_120,
      CE => ARC_CRCStart_27,
      D => n0455(9),
      R => ENT_DeviceResetEvent_ARC_DeviceStatus_OR_17_o,
      Q => ARC_CRCDataMosiComputer(3)
    );
  ARC_CRCDataMosiComputer_4 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => ARC_DataReceiveEvent_120,
      CE => ARC_CRCStart_27,
      D => n0452(9),
      R => ENT_DeviceResetEvent_ARC_DeviceStatus_OR_17_o,
      Q => ARC_CRCDataMosiComputer(4)
    );
  ARC_CRCDataMosiComputer_5 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => ARC_DataReceiveEvent_120,
      CE => ARC_CRCStart_27,
      D => n0449(9),
      R => ENT_DeviceResetEvent_ARC_DeviceStatus_OR_17_o,
      Q => ARC_CRCDataMosiComputer(5)
    );
  ARC_CRCDataMosiComputer_6 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => ARC_DataReceiveEvent_120,
      CE => ARC_CRCStart_27,
      D => n0446(9),
      R => ENT_DeviceResetEvent_ARC_DeviceStatus_OR_17_o,
      Q => ARC_CRCDataMosiComputer(6)
    );
  ARC_CRCDataMosiComputer_7 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => ARC_DataReceiveEvent_120,
      CE => ARC_CRCStart_27,
      D => n0443(9),
      R => ENT_DeviceResetEvent_ARC_DeviceStatus_OR_17_o,
      Q => ARC_CRCDataMosiComputer(7)
    );
  ARC_CRCCheckError : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => ARC_DataMosiEmptySet_66,
      CE => ARC_CRCDataMosiCheckAccess_52,
      CLR => ENT_DeviceResetEvent_ARC_DeviceStatus_OR_17_o,
      D => ARC_CRCDataMosiComputer_7_INV_76_o,
      Q => ARC_CRCCheckError_109
    );
  Mmux_ENT_MISO_2_f7 : MUXF7
    port map (
      I0 => Mmux_ENT_MISO_4_151,
      I1 => Mmux_ENT_MISO_3_152,
      S => ARC_Counter(2),
      O => ENT_MISO_OBUF_129
    );
  Mmux_ENT_MISO_4 : LUT6
    generic map(
      INIT => X"FD75B931EC64A820"
    )
    port map (
      I0 => ARC_Counter(1),
      I1 => ARC_Counter(0),
      I2 => ARC_DataMiso(2),
      I3 => ARC_DataMiso(3),
      I4 => ARC_DataMiso(1),
      I5 => ARC_DataMiso(0),
      O => Mmux_ENT_MISO_4_151
    );
  Mmux_ENT_MISO_3 : LUT6
    generic map(
      INIT => X"FD75B931EC64A820"
    )
    port map (
      I0 => ARC_Counter(1),
      I1 => ARC_Counter(0),
      I2 => ARC_DataMiso(6),
      I3 => ARC_DataMiso(7),
      I4 => ARC_DataMiso(5),
      I5 => ARC_DataMiso(4),
      O => Mmux_ENT_MISO_3_152
    );
  ENT_NSS_ENT_DeviceResetEvent_OR_8_o1 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => ENT_NSS_IBUF_193,
      I1 => ENT_DeviceResetEvent_IBUF_13,
      O => ENT_NSS_ENT_DeviceResetEvent_OR_8_o
    );
  ENT_DeviceResetEvent_ARC_DataMisoTempEmptyReset_OR_2_o1 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => ENT_DeviceResetEvent_IBUF_13,
      I1 => ARC_DataMisoTempEmptyReset_24,
      O => ENT_DeviceResetEvent_ARC_DataMisoTempEmptyReset_OR_2_o
    );
  ENT_DeviceResetEvent_ARC_DataMisoReset_OR_5_o1 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => ENT_DeviceResetEvent_IBUF_13,
      I1 => ARC_DataMisoReset_53,
      O => ENT_DeviceResetEvent_ARC_DataMisoReset_OR_5_o
    );
  ENT_DeviceResetEvent_ARC_DeviceStatus_AND_10_o1 : LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => ENT_DeviceResetEvent_IBUF_13,
      I1 => ARC_DeviceStatus_1_192,
      O => ENT_DeviceResetEvent_ARC_DeviceStatus_AND_10_o
    );
  ENT_DeviceResetEvent_ARC_DeviceStatus_OR_17_o1 : LUT2
    generic map(
      INIT => X"B"
    )
    port map (
      I0 => ENT_DeviceResetEvent_IBUF_13,
      I1 => ARC_DeviceStatus_77,
      O => ENT_DeviceResetEvent_ARC_DeviceStatus_OR_17_o
    );
  ARC_CRCDataNewEventReset_ENT_DeviceResetEvent_OR_16_o1 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => ARC_CRCDataNewEventReset_26,
      I1 => ENT_DeviceResetEvent_IBUF_13,
      O => ARC_CRCDataNewEventReset_ENT_DeviceResetEvent_OR_16_o
    );
  ARC_CRCStartReset_ENT_DeviceResetEvent_OR_4_o1 : LUT3
    generic map(
      INIT => X"EF"
    )
    port map (
      I0 => ARC_CRCStartReset_23,
      I1 => ENT_DeviceResetEvent_IBUF_13,
      I2 => ARC_DeviceStatus_77,
      O => ARC_CRCStartReset_ENT_DeviceResetEvent_OR_4_o
    );
  ARC_DataMosiEmptyReset_ENT_DeviceResetEvent_OR_12_o1 : LUT3
    generic map(
      INIT => X"EF"
    )
    port map (
      I0 => ARC_DataMosiEmptyReset_56,
      I1 => ENT_DeviceResetEvent_IBUF_13,
      I2 => ARC_DeviceStatus_77,
      O => ARC_DataMosiEmptyReset_ENT_DeviceResetEvent_OR_12_o
    );
  ARC_CounterSCKEventReset_ENT_DeviceResetEvent_OR_10_o1 : LUT3
    generic map(
      INIT => X"EF"
    )
    port map (
      I0 => ARC_CounterSCKEventReset_38,
      I1 => ENT_DeviceResetEvent_IBUF_13,
      I2 => ARC_DeviceStatus_77,
      O => ARC_CounterSCKEventReset_ENT_DeviceResetEvent_OR_10_o
    );
  ARC_CRCEvent_ARC_DataMisoEmptyFlag_AND_2_o1 : LUT3
    generic map(
      INIT => X"20"
    )
    port map (
      I0 => ARC_CRCEvent_87,
      I1 => DataMisoControl_PROC_DataMisoEmptyFlag_28,
      I2 => ARC_DataMisoTempEmptyFlag_54,
      O => ARC_CRCEvent_ARC_DataMisoEmptyFlag_AND_2_o
    );
  ENT_Error_2_1 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => ARC_NSSErrorHighNSS_76,
      I1 => ARC_NSSErrorLowNSS_78,
      O => ENT_Error_2_OBUF_122
    );
  ARC_Counter_2_Decoder_21_OUT_7_2_1 : LUT3
    generic map(
      INIT => X"80"
    )
    port map (
      I0 => ARC_Counter(2),
      I1 => ARC_Counter(1),
      I2 => ARC_Counter(0),
      O => ARC_Counter_2_Decoder_21_OUT_7_Q
    );
  ARC_Counter_2_Decoder_21_OUT_0_1 : LUT3
    generic map(
      INIT => X"01"
    )
    port map (
      I0 => ARC_Counter(2),
      I1 => ARC_Counter(1),
      I2 => ARC_Counter(0),
      O => ARC_Counter_2_Decoder_21_OUT_0_Q
    );
  n0358_9_1 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => ARC_DataMiso(1),
      I1 => ARC_DataMiso(7),
      O => n0358(9)
    );
  n0437_9_1 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => ARC_DataMosiTemp(1),
      I1 => ARC_DataMosiTemp(7),
      O => n0437(9)
    );
  n0361_9_1 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => ARC_DataMiso(0),
      I1 => ARC_DataMiso(6),
      O => n0361(9)
    );
  n0440_9_1 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => ARC_DataMosiTemp(0),
      I1 => ARC_DataMosiTemp(6),
      O => n0440(9)
    );
  n0364_9_1 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => ARC_DataMiso(7),
      I1 => ARC_DataMiso(5),
      O => n0364(9)
    );
  n0443_9_1 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => ARC_DataMosiTemp(7),
      I1 => ARC_DataMosiTemp(5),
      O => n0443(9)
    );
  n0367_9_1 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => ARC_DataMiso(6),
      I1 => ARC_DataMiso(4),
      O => n0367(9)
    );
  n0446_9_1 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => ARC_DataMosiTemp(6),
      I1 => ARC_DataMosiTemp(4),
      O => n0446(9)
    );
  n0370_9_1 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => ARC_DataMiso(5),
      I1 => ARC_DataMiso(3),
      O => n0370(9)
    );
  n0449_9_1 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => ARC_DataMosiTemp(5),
      I1 => ARC_DataMosiTemp(3),
      O => n0449(9)
    );
  n0373_9_1 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => ARC_DataMiso(4),
      I1 => ARC_DataMiso(2),
      O => n0373(9)
    );
  n0452_9_1 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => ARC_DataMosiTemp(4),
      I1 => ARC_DataMosiTemp(2),
      O => n0452(9)
    );
  Mmux_ARC_Counter_2_GND_4_o_mux_14_OUT11 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => ARC_Counter(0),
      I1 => ARC_CounterSCKEvent_57,
      O => ARC_Counter_2_GND_4_o_mux_14_OUT_0_Q
    );
  Mmux_ARC_Counter_2_GND_4_o_mux_14_OUT21 : LUT3
    generic map(
      INIT => X"9A"
    )
    port map (
      I0 => ARC_Counter(1),
      I1 => ARC_Counter(0),
      I2 => ARC_CounterSCKEvent_57,
      O => ARC_Counter_2_GND_4_o_mux_14_OUT_1_Q
    );
  Mmux_GetDataMosi_PROC_DataMosi_2_ENT_MOSI_MUX_50_o11 : LUT5
    generic map(
      INIT => X"ABAAA8AA"
    )
    port map (
      I0 => GetDataMosi_PROC_DataMosi(2),
      I1 => ARC_Counter(2),
      I2 => ARC_Counter(0),
      I3 => ARC_Counter(1),
      I4 => ENT_MOSI_IBUF_11,
      O => GetDataMosi_PROC_DataMosi_2_ENT_MOSI_MUX_50_o
    );
  Mmux_GetDataMosi_PROC_DataMosi_3_ENT_MOSI_MUX_49_o11 : LUT5
    generic map(
      INIT => X"BAAA8AAA"
    )
    port map (
      I0 => GetDataMosi_PROC_DataMosi(3),
      I1 => ARC_Counter(2),
      I2 => ARC_Counter(1),
      I3 => ARC_Counter(0),
      I4 => ENT_MOSI_IBUF_11,
      O => GetDataMosi_PROC_DataMosi_3_ENT_MOSI_MUX_49_o
    );
  Mmux_GetDataMosi_PROC_DataMosi_4_ENT_MOSI_MUX_48_o11 : LUT5
    generic map(
      INIT => X"ABAAA8AA"
    )
    port map (
      I0 => GetDataMosi_PROC_DataMosi(4),
      I1 => ARC_Counter(0),
      I2 => ARC_Counter(1),
      I3 => ARC_Counter(2),
      I4 => ENT_MOSI_IBUF_11,
      O => GetDataMosi_PROC_DataMosi_4_ENT_MOSI_MUX_48_o
    );
  Mmux_GetDataMosi_PROC_DataMosi_5_ENT_MOSI_MUX_47_o11 : LUT5
    generic map(
      INIT => X"BAAA8AAA"
    )
    port map (
      I0 => GetDataMosi_PROC_DataMosi(5),
      I1 => ARC_Counter(1),
      I2 => ARC_Counter(2),
      I3 => ARC_Counter(0),
      I4 => ENT_MOSI_IBUF_11,
      O => GetDataMosi_PROC_DataMosi_5_ENT_MOSI_MUX_47_o
    );
  Mmux_GetDataMosi_PROC_DataMosi_6_ENT_MOSI_MUX_46_o11 : LUT5
    generic map(
      INIT => X"BAAA8AAA"
    )
    port map (
      I0 => GetDataMosi_PROC_DataMosi(6),
      I1 => ARC_Counter(0),
      I2 => ARC_Counter(1),
      I3 => ARC_Counter(2),
      I4 => ENT_MOSI_IBUF_11,
      O => GetDataMosi_PROC_DataMosi_6_ENT_MOSI_MUX_46_o
    );
  Mmux_ARC_Counter_2_GND_4_o_mux_14_OUT31 : LUT4
    generic map(
      INIT => X"A9AA"
    )
    port map (
      I0 => ARC_Counter(2),
      I1 => ARC_Counter(0),
      I2 => ARC_Counter(1),
      I3 => ARC_CounterSCKEvent_57,
      O => ARC_Counter_2_GND_4_o_mux_14_OUT_2_Q
    );
  ARC_DeviceStatus_ARC_CRCDataMosiComputerEvent_AND_26_o1 : LUT5
    generic map(
      INIT => X"00080000"
    )
    port map (
      I0 => ARC_CRCDataMosiComputerEvent_128,
      I1 => ARC_DeviceStatus_77,
      I2 => ARC_Counter(2),
      I3 => ARC_Counter(1),
      I4 => ARC_Counter(0),
      O => ARC_DeviceStatus_ARC_CRCDataMosiComputerEvent_AND_26_o
    );
  Mmux_GetDataMosi_PROC_DataMosi_1_ENT_MOSI_MUX_51_o11 : LUT5
    generic map(
      INIT => X"ABAAA8AA"
    )
    port map (
      I0 => GetDataMosi_PROC_DataMosi(1),
      I1 => ARC_Counter(2),
      I2 => ARC_Counter(1),
      I3 => ARC_Counter(0),
      I4 => ENT_MOSI_IBUF_11,
      O => GetDataMosi_PROC_DataMosi_1_ENT_MOSI_MUX_51_o
    );
  ARC_CRCDataMosiComputer_7_INV_76_o1 : LUT6
    generic map(
      INIT => X"6FF6FFFFFFFF6FF6"
    )
    port map (
      I0 => GetDataMosi_PROC_DataMosi(1),
      I1 => ARC_CRCDataMosiComputer(1),
      I2 => ARC_CRCDataMosiComputer(0),
      I3 => GetDataMosi_PROC_DataMosi(0),
      I4 => ARC_CRCDataMosiComputer(7),
      I5 => GetDataMosi_PROC_DataMosi(7),
      O => ARC_CRCDataMosiComputer_7_INV_76_o1_153
    );
  ARC_CRCDataMosiComputer_7_INV_76_o2 : LUT5
    generic map(
      INIT => X"FFFF6FF6"
    )
    port map (
      I0 => ARC_CRCDataMosiComputer(6),
      I1 => GetDataMosi_PROC_DataMosi(6),
      I2 => ARC_CRCDataMosiComputer(5),
      I3 => GetDataMosi_PROC_DataMosi(5),
      I4 => ARC_CRCDataMosiComputer_7_INV_76_o1_153,
      O => ARC_CRCDataMosiComputer_7_INV_76_o2_154
    );
  ARC_CRCDataMosiComputer_7_INV_76_o3 : LUT5
    generic map(
      INIT => X"FFFF6FF6"
    )
    port map (
      I0 => ARC_CRCDataMosiComputer(4),
      I1 => GetDataMosi_PROC_DataMosi(4),
      I2 => ARC_CRCDataMosiComputer(3),
      I3 => GetDataMosi_PROC_DataMosi(3),
      I4 => ARC_CRCDataMosiComputer_7_INV_76_o2_154,
      O => ARC_CRCDataMosiComputer_7_INV_76_o3_155
    );
  ARC_CRCDataMosiComputer_7_INV_76_o4 : LUT3
    generic map(
      INIT => X"BE"
    )
    port map (
      I0 => ARC_CRCDataMosiComputer_7_INV_76_o3_155,
      I1 => ARC_CRCDataMosiComputer(2),
      I2 => GetDataMosi_PROC_DataMosi(2),
      O => ARC_CRCDataMosiComputer_7_INV_76_o
    );
  ENT_NSS_IBUF : IBUF
    port map (
      I => ENT_NSS,
      O => ENT_NSS_IBUF_193
    );
  ENT_DataIn_7_IBUF : IBUF
    port map (
      I => ENT_DataIn(7),
      O => ENT_DataIn_7_IBUF_0
    );
  ENT_DataIn_6_IBUF : IBUF
    port map (
      I => ENT_DataIn(6),
      O => ENT_DataIn_6_IBUF_1
    );
  ENT_DataIn_5_IBUF : IBUF
    port map (
      I => ENT_DataIn(5),
      O => ENT_DataIn_5_IBUF_2
    );
  ENT_DataIn_4_IBUF : IBUF
    port map (
      I => ENT_DataIn(4),
      O => ENT_DataIn_4_IBUF_3
    );
  ENT_DataIn_3_IBUF : IBUF
    port map (
      I => ENT_DataIn(3),
      O => ENT_DataIn_3_IBUF_4
    );
  ENT_DataIn_2_IBUF : IBUF
    port map (
      I => ENT_DataIn(2),
      O => ENT_DataIn_2_IBUF_5
    );
  ENT_DataIn_1_IBUF : IBUF
    port map (
      I => ENT_DataIn(1),
      O => ENT_DataIn_1_IBUF_6
    );
  ENT_DataIn_0_IBUF : IBUF
    port map (
      I => ENT_DataIn(0),
      O => ENT_DataIn_0_IBUF_7
    );
  ENT_MOSI_IBUF : IBUF
    port map (
      I => ENT_MOSI,
      O => ENT_MOSI_IBUF_11
    );
  ENT_DeviceResetEvent_IBUF : IBUF
    port map (
      I => ENT_DeviceResetEvent,
      O => ENT_DeviceResetEvent_IBUF_13
    );
  ENT_DataOut_7_OBUF : OBUF
    port map (
      I => ARC_DataMosiTemp_7_1_194,
      O => ENT_DataOut(7)
    );
  ENT_DataOut_6_OBUF : OBUF
    port map (
      I => ARC_DataMosiTemp_6_1_195,
      O => ENT_DataOut(6)
    );
  ENT_DataOut_5_OBUF : OBUF
    port map (
      I => ARC_DataMosiTemp_5_1_196,
      O => ENT_DataOut(5)
    );
  ENT_DataOut_4_OBUF : OBUF
    port map (
      I => ARC_DataMosiTemp_4_1_197,
      O => ENT_DataOut(4)
    );
  ENT_DataOut_3_OBUF : OBUF
    port map (
      I => ARC_DataMosiTemp_3_1_198,
      O => ENT_DataOut(3)
    );
  ENT_DataOut_2_OBUF : OBUF
    port map (
      I => ARC_DataMosiTemp_2_1_199,
      O => ENT_DataOut(2)
    );
  ENT_DataOut_1_OBUF : OBUF
    port map (
      I => ARC_DataMosiTemp_1_1_200,
      O => ENT_DataOut(1)
    );
  ENT_DataOut_0_OBUF : OBUF
    port map (
      I => ARC_DataMosiTemp_0_1_201,
      O => ENT_DataOut(0)
    );
  ENT_Error_2_OBUF : OBUF
    port map (
      I => ENT_Error_2_OBUF_122,
      O => ENT_Error(2)
    );
  ENT_Error_1_OBUF : OBUF
    port map (
      I => ARC_DataMisoTempError_55,
      O => ENT_Error(1)
    );
  ENT_Error_0_OBUF : OBUF
    port map (
      I => ARC_CRCCheckError_109,
      O => ENT_Error(0)
    );
  ENT_MISO_OBUF : OBUF
    port map (
      I => ENT_MISO_OBUF_129,
      O => ENT_MISO
    );
  ENT_DataEmpty_OBUF : OBUF
    port map (
      I => ARC_DataMisoTempEmptyFlag_1_202,
      O => ENT_DataEmpty
    );
  ENT_DataReceiveEvent_OBUF : OBUF
    port map (
      I => ARC_DataReceiveEvent_1_203,
      O => ENT_DataReceiveEvent
    );
  ARC_CRCDataMosiComputerEvent : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => ARC_DataReceiveEvent_120,
      D => ARC_CRCDataMosiComputerEvent_glue_set_185,
      Q => ARC_CRCDataMosiComputerEvent_128
    );
  ARC_DeviceStatus : FDC_1
    generic map(
      INIT => '0'
    )
    port map (
      C => ENT_NSS_IBUF_BUFG_12,
      CLR => ENT_NSS_ENT_DeviceResetEvent_OR_8_o,
      D => ARC_DeviceStatus_rstpot_186,
      Q => ARC_DeviceStatus_77
    );
  ARC_NSSErrorLowNSS : FDC_1
    generic map(
      INIT => '0'
    )
    port map (
      C => ENT_NSS_IBUF_BUFG_12,
      CLR => ENT_NSS_ENT_DeviceResetEvent_OR_8_o,
      D => ARC_NSSErrorLowNSS_rstpot_187,
      Q => ARC_NSSErrorLowNSS_78
    );
  ARC_DataMisoTempError : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => ENT_DataNewEvent_BUFGP_9,
      CLR => ENT_DeviceResetEvent_ARC_DataMisoTempEmptyReset_OR_2_o,
      D => ARC_DataMisoTempError_rstpot_188,
      Q => ARC_DataMisoTempError_55
    );
  ARC_DataFrameComputer : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => ENT_ClkIn_BUFGP_8,
      D => ARC_DataFrameComputer_rstpot_189,
      Q => ARC_DataFrameComputer_39
    );
  CRC_DataInput_PROC_DataOne : FD
    generic map(
      INIT => '1'
    )
    port map (
      C => ENT_ClkIn_BUFGP_8,
      D => CRC_DataInput_PROC_DataOne_rstpot_190,
      Q => CRC_DataInput_PROC_DataOne_51
    );
  ARC_DataMisoReset : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => ENT_ClkIn_BUFGP_8,
      D => ARC_DataMisoReset_rstpot1_191,
      Q => ARC_DataMisoReset_53
    );
  ARC_DataMisoTempError_rstpot : LUT2
    generic map(
      INIT => X"B"
    )
    port map (
      I0 => ARC_DataMisoTempError_55,
      I1 => DataMisoControl_PROC_DataMisoEmptyFlag_28,
      O => ARC_DataMisoTempError_rstpot_188
    );
  ARC_DataFrameComputer_PWR_4_o_MUX_23_o1 : LUT5
    generic map(
      INIT => X"89880100"
    )
    port map (
      I0 => ARC_CRCStart_27,
      I1 => DataMisoControl_PROC_DataTransmitEnd_37,
      I2 => ARC_DataMisoTempEmptyFlag_54,
      I3 => DataMisoControl_PROC_DataMisoEmptyFlag_28,
      I4 => ARC_DataFrameComputer_39,
      O => ARC_DataFrameComputer_PWR_4_o_MUX_23_o
    );
  Q_n0675_inv1 : LUT4
    generic map(
      INIT => X"A280"
    )
    port map (
      I0 => ARC_CRCDataNewEventFlag_104,
      I1 => CRC_DataInput_PROC_DataOne_51,
      I2 => ARC_CRCEvent_87,
      I3 => ARC_CRCDataInputCompute_25,
      O => Q_n0675_inv
    );
  Mmux_ARC_DataMiso_7_ARC_DataMisoTemp_7_mux_6_OUT81 : LUT6
    generic map(
      INIT => X"AAAAAABAAAAAAA8A"
    )
    port map (
      I0 => ARC_CRCDataOutput(7),
      I1 => ARC_CRCStart_27,
      I2 => DataMisoControl_PROC_DataMisoEmptyFlag_28,
      I3 => ARC_DataMisoTempEmptyFlag_54,
      I4 => DataMisoControl_PROC_DataTransmitEnd_37,
      I5 => ARC_DataMisoTemp(7),
      O => ARC_DataMiso_7_ARC_DataMisoTemp_7_mux_6_OUT_7_Q
    );
  Mmux_ARC_DataMiso_7_ARC_DataMisoTemp_7_mux_6_OUT71 : LUT6
    generic map(
      INIT => X"AAAAAABAAAAAAA8A"
    )
    port map (
      I0 => ARC_CRCDataOutput(6),
      I1 => ARC_CRCStart_27,
      I2 => DataMisoControl_PROC_DataMisoEmptyFlag_28,
      I3 => ARC_DataMisoTempEmptyFlag_54,
      I4 => DataMisoControl_PROC_DataTransmitEnd_37,
      I5 => ARC_DataMisoTemp(6),
      O => ARC_DataMiso_7_ARC_DataMisoTemp_7_mux_6_OUT_6_Q
    );
  Mmux_ARC_DataMiso_7_ARC_DataMisoTemp_7_mux_6_OUT61 : LUT6
    generic map(
      INIT => X"AAAAAABAAAAAAA8A"
    )
    port map (
      I0 => ARC_CRCDataOutput(5),
      I1 => ARC_CRCStart_27,
      I2 => DataMisoControl_PROC_DataMisoEmptyFlag_28,
      I3 => ARC_DataMisoTempEmptyFlag_54,
      I4 => DataMisoControl_PROC_DataTransmitEnd_37,
      I5 => ARC_DataMisoTemp(5),
      O => ARC_DataMiso_7_ARC_DataMisoTemp_7_mux_6_OUT_5_Q
    );
  Mmux_ARC_DataMiso_7_ARC_DataMisoTemp_7_mux_6_OUT51 : LUT6
    generic map(
      INIT => X"AAAAAABAAAAAAA8A"
    )
    port map (
      I0 => ARC_CRCDataOutput(4),
      I1 => ARC_CRCStart_27,
      I2 => DataMisoControl_PROC_DataMisoEmptyFlag_28,
      I3 => ARC_DataMisoTempEmptyFlag_54,
      I4 => DataMisoControl_PROC_DataTransmitEnd_37,
      I5 => ARC_DataMisoTemp(4),
      O => ARC_DataMiso_7_ARC_DataMisoTemp_7_mux_6_OUT_4_Q
    );
  Mmux_ARC_DataMiso_7_ARC_DataMisoTemp_7_mux_6_OUT41 : LUT6
    generic map(
      INIT => X"AAAAAABAAAAAAA8A"
    )
    port map (
      I0 => ARC_CRCDataOutput(3),
      I1 => ARC_CRCStart_27,
      I2 => DataMisoControl_PROC_DataMisoEmptyFlag_28,
      I3 => ARC_DataMisoTempEmptyFlag_54,
      I4 => DataMisoControl_PROC_DataTransmitEnd_37,
      I5 => ARC_DataMisoTemp(3),
      O => ARC_DataMiso_7_ARC_DataMisoTemp_7_mux_6_OUT_3_Q
    );
  Mmux_ARC_DataMiso_7_ARC_DataMisoTemp_7_mux_6_OUT31 : LUT6
    generic map(
      INIT => X"AAAAAABAAAAAAA8A"
    )
    port map (
      I0 => ARC_CRCDataOutput(2),
      I1 => ARC_CRCStart_27,
      I2 => DataMisoControl_PROC_DataMisoEmptyFlag_28,
      I3 => ARC_DataMisoTempEmptyFlag_54,
      I4 => DataMisoControl_PROC_DataTransmitEnd_37,
      I5 => ARC_DataMisoTemp(2),
      O => ARC_DataMiso_7_ARC_DataMisoTemp_7_mux_6_OUT_2_Q
    );
  Mmux_ARC_DataMiso_7_ARC_DataMisoTemp_7_mux_6_OUT21 : LUT6
    generic map(
      INIT => X"AAAAAABAAAAAAA8A"
    )
    port map (
      I0 => ARC_CRCDataOutput(1),
      I1 => ARC_CRCStart_27,
      I2 => DataMisoControl_PROC_DataMisoEmptyFlag_28,
      I3 => ARC_DataMisoTempEmptyFlag_54,
      I4 => DataMisoControl_PROC_DataTransmitEnd_37,
      I5 => ARC_DataMisoTemp(1),
      O => ARC_DataMiso_7_ARC_DataMisoTemp_7_mux_6_OUT_1_Q
    );
  Mmux_ARC_DataMiso_7_ARC_DataMisoTemp_7_mux_6_OUT11 : LUT6
    generic map(
      INIT => X"AAAAAABAAAAAAA8A"
    )
    port map (
      I0 => ARC_CRCDataOutput(0),
      I1 => ARC_CRCStart_27,
      I2 => DataMisoControl_PROC_DataMisoEmptyFlag_28,
      I3 => ARC_DataMisoTempEmptyFlag_54,
      I4 => DataMisoControl_PROC_DataTransmitEnd_37,
      I5 => ARC_DataMisoTemp(0),
      O => ARC_DataMiso_7_ARC_DataMisoTemp_7_mux_6_OUT_0_Q
    );
  Mmux_GND_4_o_ARC_CRCEvent_MUX_24_o11 : LUT5
    generic map(
      INIT => X"00000200"
    )
    port map (
      I0 => ARC_CRCEvent_87,
      I1 => ARC_CRCStart_27,
      I2 => ARC_DataMisoTempEmptyFlag_54,
      I3 => DataMisoControl_PROC_DataMisoEmptyFlag_28,
      I4 => DataMisoControl_PROC_DataTransmitEnd_37,
      O => GND_4_o_ARC_CRCEvent_MUX_24_o
    );
  Mmux_DataMisoControl_PROC_DataTransmitEnd_ARC_CRCEvent_MUX_26_o11 : LUT5
    generic map(
      INIT => X"FFFFFFEF"
    )
    port map (
      I0 => ARC_DataMisoTempEmptyFlag_54,
      I1 => ARC_CRCStart_27,
      I2 => DataMisoControl_PROC_DataMisoEmptyFlag_28,
      I3 => ARC_CRCEvent_87,
      I4 => DataMisoControl_PROC_DataTransmitEnd_37,
      O => DataMisoControl_PROC_DataTransmitEnd_ARC_CRCEvent_MUX_26_o
    );
  n0376_9_1 : LUT3
    generic map(
      INIT => X"96"
    )
    port map (
      I0 => ARC_DataMiso(3),
      I1 => ARC_DataMiso(1),
      I2 => ARC_DataMiso(7),
      O => n0376(9)
    );
  Mmux_ARC_CRCDataOutput_7_ARC_CRCDataOutput_7_mux_108_OUT31 : LUT3
    generic map(
      INIT => X"96"
    )
    port map (
      I0 => ARC_DataMiso(2),
      I1 => ARC_DataMiso(0),
      I2 => ARC_DataMiso(6),
      O => ARC_CRCDataOutput_7_ARC_CRCDataOutput_7_mux_108_OUT_2_Q
    );
  Mmux_GetDataMosi_PROC_DataMosi_7_ENT_MOSI_MUX_45_o11 : LUT5
    generic map(
      INIT => X"EAAA2AAA"
    )
    port map (
      I0 => GetDataMosi_PROC_DataMosi(7),
      I1 => ARC_Counter(2),
      I2 => ARC_Counter(1),
      I3 => ARC_Counter(0),
      I4 => ENT_MOSI_IBUF_11,
      O => GetDataMosi_PROC_DataMosi_7_ENT_MOSI_MUX_45_o
    );
  Mmux_GetDataMosi_PROC_DataMosi_0_ENT_MOSI_MUX_52_o11 : LUT5
    generic map(
      INIT => X"AAABAAA8"
    )
    port map (
      I0 => GetDataMosi_PROC_DataMosi(0),
      I1 => ARC_Counter(2),
      I2 => ARC_Counter(1),
      I3 => ARC_Counter(0),
      I4 => ENT_MOSI_IBUF_11,
      O => GetDataMosi_PROC_DataMosi_0_ENT_MOSI_MUX_52_o
    );
  ARC_DeviceStatus_rstpot : LUT4
    generic map(
      INIT => X"FF80"
    )
    port map (
      I0 => ARC_Counter(2),
      I1 => ARC_Counter(1),
      I2 => ARC_Counter(0),
      I3 => ARC_DeviceStatus_77,
      O => ARC_DeviceStatus_rstpot_186
    );
  CRC_DataInput_PROC_DataOne_rstpot : LUT4
    generic map(
      INIT => X"DA8A"
    )
    port map (
      I0 => CRC_DataInput_PROC_DataOne_51,
      I1 => ARC_CRCEvent_87,
      I2 => ARC_CRCDataNewEventFlag_104,
      I3 => ARC_CRCDataInputCompute_25,
      O => CRC_DataInput_PROC_DataOne_rstpot_190
    );
  ENT_DeviceResetEvent_ARC_DeviceStatus_OR_14_o1 : LUT3
    generic map(
      INIT => X"EF"
    )
    port map (
      I0 => ENT_NSS_IBUF_193,
      I1 => ENT_DeviceResetEvent_IBUF_13,
      I2 => ARC_DeviceStatus_77,
      O => ENT_DeviceResetEvent_ARC_DeviceStatus_OR_14_o
    );
  Q_n0653_inv1 : LUT4
    generic map(
      INIT => X"1555"
    )
    port map (
      I0 => ARC_CRCStart_27,
      I1 => ARC_Counter(1),
      I2 => ARC_Counter(0),
      I3 => ARC_Counter(2),
      O => Q_n0653_inv
    );
  Mmux_GND_4_o_GND_4_o_MUX_54_o11 : LUT4
    generic map(
      INIT => X"AAA8"
    )
    port map (
      I0 => ARC_DeviceStatus_77,
      I1 => ARC_Counter(2),
      I2 => ARC_Counter(1),
      I3 => ARC_Counter(0),
      O => GND_4_o_GND_4_o_MUX_54_o
    );
  n0455_9_1 : LUT3
    generic map(
      INIT => X"96"
    )
    port map (
      I0 => ARC_DataMosiTemp(3),
      I1 => ARC_DataMosiTemp(1),
      I2 => ARC_DataMosiTemp(7),
      O => n0455(9)
    );
  Mmux_n063381 : LUT3
    generic map(
      INIT => X"96"
    )
    port map (
      I0 => ARC_DataMosiTemp(2),
      I1 => ARC_DataMosiTemp(0),
      I2 => ARC_DataMosiTemp(6),
      O => Q_n0633(9)
    );
  ARC_DataMisoReset_rstpot1 : LUT5
    generic map(
      INIT => X"75552000"
    )
    port map (
      I0 => ARC_DeviceStatus_77,
      I1 => ARC_CRCStart_27,
      I2 => ARC_Counter_2_Decoder_21_OUT_7_Q,
      I3 => ARC_DataFrameComputer_39,
      I4 => ARC_DataMisoReset_53,
      O => ARC_DataMisoReset_rstpot1_191
    );
  ARC_CRCDataMosiComputerEvent_glue_set : LUT4
    generic map(
      INIT => X"AEAA"
    )
    port map (
      I0 => ARC_CRCDataMosiComputerEvent_128,
      I1 => ARC_CRCStart_27,
      I2 => ENT_DeviceResetEvent_IBUF_13,
      I3 => ARC_DeviceStatus_77,
      O => ARC_CRCDataMosiComputerEvent_glue_set_185
    );
  ARC_NSSErrorLowNSS_rstpot : LUT4
    generic map(
      INIT => X"FF7F"
    )
    port map (
      I0 => ARC_Counter(2),
      I1 => ARC_Counter(1),
      I2 => ARC_Counter(0),
      I3 => ARC_NSSErrorLowNSS_78,
      O => ARC_NSSErrorLowNSS_rstpot_187
    );
  ARC_DataFrameComputer_rstpot : LUT6
    generic map(
      INIT => X"2A2A2A2A2A2A2AEA"
    )
    port map (
      I0 => ARC_DataFrameComputer_39,
      I1 => ARC_DeviceStatus_77,
      I2 => ARC_CounterSCKEvent_57,
      I3 => ARC_Counter(2),
      I4 => ARC_Counter(1),
      I5 => ARC_Counter(0),
      O => ARC_DataFrameComputer_rstpot_189
    );
  ARC_DeviceStatus_1 : FDC_1
    generic map(
      INIT => '0'
    )
    port map (
      C => ENT_NSS_IBUF_BUFG_12,
      CLR => ENT_NSS_ENT_DeviceResetEvent_OR_8_o,
      D => ARC_DeviceStatus_rstpot_186,
      Q => ARC_DeviceStatus_1_192
    );
  ENT_ClkIn_BUFGP : BUFGP
    port map (
      I => ENT_ClkIn,
      O => ENT_ClkIn_BUFGP_8
    );
  ENT_SCK_BUFGP : BUFGP
    port map (
      I => ENT_SCK,
      O => ENT_SCK_BUFGP_10
    );
  ENT_DataNewEvent_BUFGP : BUFGP
    port map (
      I => ENT_DataNewEvent,
      O => ENT_DataNewEvent_BUFGP_9
    );
  ENT_NSS_IBUF_BUFG : BUFG
    port map (
      O => ENT_NSS_IBUF_BUFG_12,
      I => ENT_NSS_IBUF_193
    );
  ENT_CRCEvent_BUFGP : BUFGP
    port map (
      I => ENT_CRCEvent,
      O => ENT_CRCEvent_BUFGP_14
    );
  ARC_DataMosiTemp_7_1 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => ARC_DataMosiEmptySet_66,
      D => GetDataMosi_PROC_DataMosi(7),
      Q => ARC_DataMosiTemp_7_1_194
    );
  ARC_DataMosiTemp_6_1 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => ARC_DataMosiEmptySet_66,
      D => GetDataMosi_PROC_DataMosi(6),
      Q => ARC_DataMosiTemp_6_1_195
    );
  ARC_DataMosiTemp_5_1 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => ARC_DataMosiEmptySet_66,
      D => GetDataMosi_PROC_DataMosi(5),
      Q => ARC_DataMosiTemp_5_1_196
    );
  ARC_DataMosiTemp_4_1 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => ARC_DataMosiEmptySet_66,
      D => GetDataMosi_PROC_DataMosi(4),
      Q => ARC_DataMosiTemp_4_1_197
    );
  ARC_DataMosiTemp_3_1 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => ARC_DataMosiEmptySet_66,
      D => GetDataMosi_PROC_DataMosi(3),
      Q => ARC_DataMosiTemp_3_1_198
    );
  ARC_DataMosiTemp_2_1 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => ARC_DataMosiEmptySet_66,
      D => GetDataMosi_PROC_DataMosi(2),
      Q => ARC_DataMosiTemp_2_1_199
    );
  ARC_DataMosiTemp_1_1 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => ARC_DataMosiEmptySet_66,
      D => GetDataMosi_PROC_DataMosi(1),
      Q => ARC_DataMosiTemp_1_1_200
    );
  ARC_DataMosiTemp_0_1 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => ARC_DataMosiEmptySet_66,
      D => GetDataMosi_PROC_DataMosi(0),
      Q => ARC_DataMosiTemp_0_1_201
    );
  ARC_DataMisoTempEmptyFlag_1 : FDP
    generic map(
      INIT => '1'
    )
    port map (
      C => ENT_DataNewEvent_BUFGP_9,
      D => N1,
      PRE => ENT_DeviceResetEvent_ARC_DataMisoTempEmptyReset_OR_2_o,
      Q => ARC_DataMisoTempEmptyFlag_1_202
    );
  ARC_DataReceiveEvent_1 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => ARC_DataMosiEmptySet_66,
      CLR => ARC_DataMosiEmptyReset_ENT_DeviceResetEvent_OR_12_o,
      D => N0,
      Q => ARC_DataReceiveEvent_1_203
    );

end Structure;

