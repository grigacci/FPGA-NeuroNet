library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

package CONFIG is
    constant weight_size  	: integer := 8;  	--Weight size
	constant data_size 		: integer := 16;	--Data size

	constant number_of_neurons : integer := 20;
	constant input_size		: integer := 784;

	constant largura_ende 	: integer  :=  10;   -- tamanho do endereço dos 'weights'
	constant conexoes     	: integer  :=  784;

	constant output_classes : integer := 10;	--Number os possible outputs
end CONFIG;