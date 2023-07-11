library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.float_pkg.all;
use work.CONFIG.ALL;
use work.mulmat_soft_mem.ALL;
use work.bfloat_pkg.ALL;

entity mulmat_soft is
    generic (
        instance_number : integer
    );

    port (
        data_in_mulmat_soft        : in bfloat16;    
        connection_in_mulmat_soft  : in std_logic_vector(5 downto 0);
        clk_mulmat_soft            : in std_logic;
        --valid_in_mulmat       : in std_logic;

        data_o_mulmat_soft       : out bfloat16;
        done_o_mulmat_soft         : out std_logic
    );
end mulmat_soft;

architecture comportamental of mulmat_soft is

    type float_array is array (0 to number_of_neurons - 1) of float (0 downto -weight_size + 1);
    signal weight : float_array; 
    signal initialized : boolean := False;
    --signal one : std_logic_vector(output_classes - 1 downto 0) := (others => '1');

begin
    process(data_in_mulmat_soft,connection_in_mulmat_soft,clk_mulmat_soft)
    begin
        if(rising_edge(clk_mulmat_soft)) then
        if initialized = false then                 --initialize the weight array
            for i in 0 to number_of_neurons - 1 loop
                weight(i) <= soft_weights(i,instance_number);
            end loop;
            initialized <= True; 
        end if;

        if(to_integer(unsigned(connection_in_mulmat_soft)) = input_size - 1) then
            done_o_mulmat_soft <= '1';
        else
            data_o_mulmat_soft <= data_in_mulmat_soft * weight(to_integer(unsigned(connection_in_mulmat_soft)));
            done_o_mulmat_soft <= '0';
        end if;

        end if;
    end process;
end comportamental;
