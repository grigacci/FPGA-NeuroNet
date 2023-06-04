library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.CONFIG.ALL;

entity softmax is
    port (
        data_in_softmax   : in std_logic_vector(weight_size - 1 downto 0);    
        sel     : out std_logic_vector(3 downto 0);
        data_out_softmax  : out std_logic_vector(weight_size - 1 downto 0)
    );
end softmax;

architecture comportamental of softmax is
type one_hot_enconding is array (0 to 9) of std_logic_vector(weight_size - 1 downto 0);
signal one_hot : one_hot_enconding;
variable index : integer := 0;
variable foundmax : std_logic_vector(weight_size - 1 downto 0) := (others => '0');

begin
    process(data_in_softmax,sel)
    begin
        for i in 0 to 9 loop
            sel <= std_logic_vector(to_unsigned(i,sel'length));         --Select the mux data_out_softmax
            one_hot(i) <= data_in_softmax;                                        --Add the input to the array
            if (one_hot(i) >= foundmax) then                            --Find the max value of the array
                foundmax := one_hot(i);                                 --Aux to save the max value yet
                index := i;                                             --Save the index of the max value
            end if;
        end loop;
        data_out_softmax <= std_logic_vector(to_unsigned(index,data_out_softmax'length));   --Return the max value of the array
    end process;
end comportamental;
