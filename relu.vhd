library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.CONFIG.ALL;

entity relu is
    port (
        clk_relu       : in std_logic;
        data_in_relu   : in std_logic_vector(data_size - 1 downto 0);
        data_out_relu  : out std_logic_vector(data_size - 1 downto 0);
        clk_o_relu     : out std_logic
    );
end relu;

architecture comportamental of relu is
    signal zero : std_logic_vector(data_size - 1 downto 0) := ((others => '0'));
begin
    process(data_in_relu)
    begin
    if (data_in_relu > zero) then
        data_out_relu <= data_in_relu;
    else 
        data_out_relu <= ((others => '0'));
    end if;

    clk_o_relu <= clk_relu;
    end process;
end comportamental;
