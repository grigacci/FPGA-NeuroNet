library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.float_pkg.all;
use work.CONFIG.ALL;
use work.mulmat_relu_mem.ALL;
use ieee.fixed_pkg.all;
use work.bfloat_pkg.ALL;

entity mulmat_relu is
    generic (
        instance_number : integer
    );

    port (
        ready_in_mulmat       : in std_logic_vector(output_classes - 1 downto 0);
        data_in_mulmat        : in bfloat16;    
        addr_in_mulmat        : in std_logic_vector(address_size - 1 downto 0);
        clk_in_mulmat         : in std_logic;

        data_out_mulmat       : out bfloat16;
        done_o_mulmat         : out std_logic
    );
end mulmat_relu;

architecture comportamental of mulmat_relu is

    type float_array is array (0 to input_size - 1) of f4;
    signal weight : float_array; 
    signal initialized : boolean := False;
    signal one : std_logic_vector(output_classes - 1 downto 0) := (others => '1');
begin
    process(data_in_mulmat,addr_in_mulmat,clk_in_mulmat )
    begin
        if(rising_edge(clk_in_mulmat )) then
            if initialized = false then                 --initialize the weight array
                for i in 0 to input_size - 1 loop
                    weight(i) <= relu_weights(i,instance_number);
                end loop;
                initialized <= True; 
            end if;

            if(to_integer(unsigned(addr_in_mulmat)) = input_size - 1) then
                done_o_mulmat <= '1';
         
            else
                data_out_mulmat <= data_in_mulmat * (weight(to_integer(unsigned(addr_in_mulmat))));
                done_o_mulmat <= '0';
            end if;
        end if;
    end process;
end comportamental;
