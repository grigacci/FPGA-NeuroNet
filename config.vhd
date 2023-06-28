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

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.float_pkg.all;
use work.CONFIG.ALL;

package bfloat_pkg is 
	subtype bfloat16 is float(8 downto -7);
	type bus_bfloat16 is array(natural range<>) of bfloat16;

	subtype f4 is float(0 downto -weight_size + 1);

    function to_f4(raw_num : real) return f4;
	function to_bfloat16(raw_num : real) return bfloat16;

end package;

package body bfloat_pkg is 
	function to_f4(raw_num : real) return f4 is 
        variable converted : f4;
    begin
        converted := to_float(raw_num)(0 downto -weight_size + 1);
    return converted;
    end function;

	function to_bfloat16(raw_num : real) return bfloat16 is 
        variable converted : bfloat16;
    begin
        converted := to_float(raw_num)(8 downto -7);
    return converted;
    end function;

end package body;
