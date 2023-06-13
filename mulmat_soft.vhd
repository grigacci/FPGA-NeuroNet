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
        data_in_mulmat        : in bfloat16;    
        addr_in_mulmat        : in std_logic_vector(address_size - 1 downto 0);
        clk_mulmat            : in std_logic;
        --valid_in_mulmat       : in std_logic;

        data_out_mulmat       : out bfloat16;
        done_o_mulmat         : out std_logic;
        ready_o_mulmat        : out std_logic;
        clk_o_mulmat          : out std_logic
    );
end mulmat_soft;

architecture comportamental of mulmat_soft is

    type float_array is array (0 to number_of_neurons - 1) of float (0 downto -weight_size + 1);
    signal weight : float_array; 
    variable initialized : boolean := False;

begin
    process(data_in_mulmat,addr_in_mulmat,clk_mulmat)
    begin
        if initialized = false then                 --initialize the weight array
            for i in 0 to input_size - 1 loop
                weight(i) <= soft_weights(instance_number,i);
            end loop;
            initialized := True; 
        end if;

        ready_o_mulmat <= '0';

        --if valid_in_mulmat then

        if(to_integer(unsigned(addr_in_mulmat)) = input_size - 1) then
            done_o_mulmat <= '1';
            ready_o_mulmat <= '1';
        
        else
            data_out_mulmat <= data_in_mulmat * weight(to_integer(unsigned(addr_in_mulmat)));
            done_o_mulmat <= '0';
            ready_o_mulmat <= '1';
        end if;

    clk_o_mulmat <= clk_mulmat;
    --end if;
    end process;
end comportamental;
