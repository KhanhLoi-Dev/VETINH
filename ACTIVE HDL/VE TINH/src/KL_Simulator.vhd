library ieee;
use ieee.std_logic_1164.all;
package KL_Simulator is
    --{ví trí bắt cầu cắt, chiều dài chuỗi, chuỗi đầu vào, chuỗi đầu ra}
    procedure KL_GetDataCell(PositionStart :in integer; Length_Sub: in integer; DataIn :in string; DataOut: out integer);
    --{ví trí bắt cầu cắt, chiều dài chuỗi, chuỗi đầu vào, chuỗi đầu ra(chỉ trả về 0 or 1)}
    procedure KL_GetDataCell(PositionStart :in integer; Length_Sub: in integer; DataIn :in string; DataOut: out std_logic_vector);
    --{ví trí bắt đầu, chuỗi đầu vào, đầu ra(chỉ trả về 0 or 1)}
    procedure KL_GetDataCell(PositionStart :in integer; DataIn :in string; HL: out std_logic);
end package KL_Simulator;
package body KL_Simulator is
    procedure KL_GetDataCell(PositionStart :in integer; Length_Sub: in integer; DataIn :in string; DataOut: out integer) is
  	    variable FUNC_temp: string(1 to (PositionStart +(Length_Sub -1)));
    begin	   
        FUNC_temp:= DataIn(PositionStart to (PositionStart + (Length_Sub -1))); 	
        DataOut:= integer'value(FUNC_temp);
    end procedure KL_GetDataCell;
    procedure KL_GetDataCell(PositionStart :in integer; DataIn :in string; HL: out std_logic) is
    begin
        if(DataIn(PositionStart) = '0')then
            HL:= '0';
        elsif(DataIn(PositionStart) = '1')then
            HL:= '1';
        else
            --lỗi
            assert false report "Gia tri "&DataIn(PositionStart)&" khong nam trong pham vi ('0', '1')!" severity error;
        end if;
    end procedure KL_GetDataCell;
    procedure KL_GetDataCell(PositionStart :in integer; Length_Sub: in integer; DataIn :in string; DataOut: out std_logic_vector) is
    begin
        for i in 0 to (Length_Sub -1) loop
            if(DataIn(PositionStart +i) = '0')then
                DataOut(Length_Sub -1 -i):= '0';
            elsif(DataIn(PositionStart +i) = '1')then
                DataOut(Length_Sub -1 -i):= '1';
            else
                -- lỗi
                assert false report "Gia tri "&DataIn(PositionStart to (PositionStart +Length_Sub -1))&" khong nam trong pham vi('0', '1')!" severity error;
            end if;
        end loop;
    end procedure KL_GetDataCell;
end package body KL_Simulator;