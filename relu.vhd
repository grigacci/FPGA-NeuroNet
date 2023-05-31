library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.CONFIG.ALL;


entity relu is
    port (
        input   : in std_logic_vector(weight_size - 1 downto 0);
        output  : out std_logic_vector(weight_size - 1 downto 0)
    );
end relu;

architecture comportamental of relu is
    signal zero : std_logic_vector(weight_size - 1 downto 0) := ((others => '0'));
begin
    process(input)
    begin
    if (input > zero) then
        output <= input;
    else 
        output <= ((others => '0'));
    end if;
    end process;
end comportamental;
