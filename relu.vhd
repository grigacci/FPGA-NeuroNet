library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.CONFIG.ALL;
use work.bfloat_pkg.ALL;
use ieee.float_pkg.all;

entity relu is
    port (
        clk_relu       : in std_logic;
        data_in_relu   : in bfloat16;

        data_o_relu    : out bfloat16
    );
end relu;

architecture comportamental of relu is
    signal zero : bfloat16 := (others => '0');
begin
    process(data_in_relu)
    begin
    if(rising_edge(clk_relu )) then
        if (data_in_relu > zero) then
            data_o_relu <= data_in_relu;
        else 
            data_o_relu <= ((others => '0'));
        end if;
    end if;
    end process;
end comportamental;
