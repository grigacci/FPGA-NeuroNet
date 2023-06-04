library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.CONFIG.ALL;

entity bias is
    port (
        data_in                 : in std_logic_vector(data_size - 1 downto 0);    
        clk_bias                : in std_logic;

        data_out                : out std_logic_vector(data_size - 1 downto 0);
        clk_o_bias              : out std_logic
    );
end bias;

architecture comportamental of bias is
    signal bias : std_logic_vector(weight_size - 1 downto 0);
    signal aux  : integer;
begin
    process(data_in,clk_bias)
    begin
        aux <= to_integer(unsigned(data_in)) + to_integer(unsigned(bias));
        data_out <= std_logic_vector(to_unsigned(aux,data_out'length));
        clk_o_bias <= clk_bias;
    end process;
end comportamental;
