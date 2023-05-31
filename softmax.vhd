library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.CONFIG.ALL;


entity softmax is
    port (
        input   : in std_logic_vector(weight_size - 1 downto 0);
        sel     : out std_logic_vector(3 downto 0);
        output  : out std_logic_vector(weight_size - 1 downto 0)
    );
end softmax;

architecture rtl of softmax is
type one_hot_enconding is array (0 to 9) of std_logic_vector(weight_size - 1 downto 0);
signal one_hot : one_hot_enconding;
begin
    process(input,sel)
    begin
        for i in 0 to 9 loop
            sel <= std_logic_vector(to_unsigned(i,sel'length));
            one_hot(i) <= input;
        end loop;
    end process;
end rtl;
