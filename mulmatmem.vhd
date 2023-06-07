library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.CONFIG.ALL;
use ieee.float_pkg.all;

package mulmatmem is
    type f_array is array (number_of_neurons - 1 downto 0, input_size -1 downto 0)  of  float (weight_size - 1 downto 0);
    signal weights : f_array;

end mulmatmem;