library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.CONFIG.ALL;
use work.bfloat_pkg.ALL;
use ieee.float_pkg.all;

entity acummulator is
    port (
        data_in_acc         : in bfloat16;    
        done_in_acc         : in std_logic;
        clk_acc             : in std_logic;

        data_o_acc          : out bfloat16
    );
end acummulator;

architecture comportamental of acummulator is
signal out_acc : bfloat16 := (others => '0');
signal parcial : bfloat16 := ((others => '0')); 
begin
    process(data_in_acc,done_in_acc,clk_acc)
    begin
        if(rising_edge(clk_acc)) then
            if (done_in_acc = '0')  then
            parcial <= parcial + data_in_acc;

            else 
                out_acc <= parcial;
                parcial <= (others => '0'); 
            end if;

        data_o_acc <= out_acc;

        end if;
    end process;
end comportamental;
