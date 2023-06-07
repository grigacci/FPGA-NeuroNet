library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.float_pkg.all;
use work.CONFIG.ALL;

entity bias is
    port (
        data_in_bias            : in std_logic_vector(data_size - 1 downto 0);    
        clk_bias                : in std_logic;

        data_o_bias             : out std_logic_vector(data_size - 1 downto 0);
        clk_o_bias              : out std_logic
    );
end bias;

architecture comportamental of bias is
    signal bias : float(bias_size - 1 downto 0);
    signal aux  : integer;
begin
    process(data_in_bias,clk_bias)
    begin
        aux <= to_integer(signed(data_in_bias)) + to_integer(signed(bias));
        data_o_bias <= std_logic_vector(to_signed(aux,data_o_bias'length));
        clk_o_bias <= clk_bias;
    end process;
end comportamental;
