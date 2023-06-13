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

        data_o_relu    : out bfloat16;
        clk_o_relu     : out std_logic
    );
end relu;

architecture comportamental of relu is
begin
    process(data_in_relu)
    begin
    if (data_in_relu > (others => '0')) then
        data_o_relu <= data_in_relu;
    else 
        data_o_relu <= ((others => '0'));
    end if;

    clk_o_relu <= clk_relu;
    end process;
end comportamental;
