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

architecture comportamental of softmax is
type one_hot_enconding is array (0 to 9) of std_logic_vector(weight_size - 1 downto 0);
signal one_hot : one_hot_enconding;
variable index : integer := 0;
variable foundmax : std_logic_vector(weight_size - 1 downto 0) := (others => '0');

begin
    process(input,sel)
    begin
        for i in 0 to 9 loop
            sel <= std_logic_vector(to_unsigned(i,sel'length));         --Select the mux output
            one_hot(i) <= input;                                        --Add the input to the array
            if (one_hot(i) >= foundmax) then                            --Find the max value of the array
                foundmax := one_hot(i);                                 --Aux to save the max value yet
                index := i;                                             --Save the index of the max value
            end if;
        end loop;
        output <= std_logic_vector(to_unsigned(index,output'length));   --Return the max value of the array
    end process;
end comportamental;
