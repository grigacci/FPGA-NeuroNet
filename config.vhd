library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

package CONFIG is
    constant weight_size  	: integer := 4;  	--Weight size
	constant bias_size		: integer := 4;		--Bias size
	constant data_size 		: integer := 16;	--Data size

	constant number_of_neurons : integer := 20;
	constant input_size		: integer := 784;

	constant address_size 	: integer  :=  10;   --Address size needed for input_size

	constant output_classes : integer := 10;	--Number os possible outputs
end CONFIG;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

package bus_multiplexer_pkg is
    type bus_array is array(natural range <>) of std_logic_vector;
end package;