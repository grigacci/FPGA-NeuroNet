library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.CONFIG.ALL;
use ieee.float_pkg.all;

package mulmat_soft_mem is
    type bias_array is array (0 to output_classes - 1) of float(0 downto -weight_size + 1); 
    type float_matrix is array (0 to output_classes - 1,0 to number_of_neurons -1)  of  float(0 downto -weight_size + 1);

    constant soft_bias : bias_array := 
    (to_float(-0.500),to_float(-0.125),to_float(-0.875),to_float(0.875),to_float(-0.625),to_float(-0.875),to_float(-0.625),to_float(-0.875),to_float(0.875),to_float(-0.625));
    
    constant soft_weights : float_matrix := 
    ((to_float(-0.250),to_float(-0.875),to_float(-0.250),to_float(-0.375),to_float(0.250),to_float(0.500),to_float(0.375),to_float(-0.875),to_float(0.875),to_float(-0.500)),
(to_float(0.125),to_float(-0.875),to_float(0.250),to_float(0.000),to_float(-0.625),to_float(-0.875),to_float(0.500),to_float(0.500),to_float(0.875),to_float(0.250)),
(to_float(0.875),to_float(-0.875),to_float(0.250),to_float(0.250),to_float(0.875),to_float(-0.625),to_float(0.875),to_float(-0.875),to_float(0.500),to_float(-0.875)),
(to_float(-0.250),to_float(0.125),to_float(-0.875),to_float(-0.750),to_float(-0.875),to_float(0.875),to_float(0.625),to_float(0.500),to_float(-0.500),to_float(0.000)),
(to_float(-0.250),to_float(0.000),to_float(-0.875),to_float(0.875),to_float(-0.875),to_float(0.875),to_float(-0.125),to_float(0.500),to_float(0.375),to_float(0.375)),
(to_float(-0.875),to_float(-0.375),to_float(-0.375),to_float(0.875),to_float(-0.250),to_float(0.500),to_float(-0.875),to_float(-0.875),to_float(0.375),to_float(0.250)),
(to_float(-0.750),to_float(-0.750),to_float(-0.625),to_float(-0.875),to_float(-0.875),to_float(0.875),to_float(0.875),to_float(-0.375),to_float(-0.250),to_float(-0.500)),
(to_float(0.250),to_float(0.875),to_float(0.625),to_float(-0.750),to_float(0.250),to_float(-0.875),to_float(0.125),to_float(0.750),to_float(-0.750),to_float(-0.125)),
(to_float(0.875),to_float(0.750),to_float(0.875),to_float(-0.250),to_float(0.000),to_float(-0.125),to_float(-0.375),to_float(-0.250),to_float(-0.875),to_float(0.250)),
(to_float(-0.875),to_float(-0.125),to_float(-0.375),to_float(0.875),to_float(0.875),to_float(0.375),to_float(-0.875),to_float(0.000),to_float(0.000),to_float(0.875)),
(to_float(0.250),to_float(0.000),to_float(0.125),to_float(-0.875),to_float(0.875),to_float(-0.625),to_float(-0.875),to_float(0.875),to_float(-0.875),to_float(0.375)),
(to_float(0.875),to_float(0.875),to_float(-0.875),to_float(-0.750),to_float(0.875),to_float(-0.125),to_float(0.875),to_float(-0.500),to_float(0.000),to_float(0.375)),
(to_float(-0.250),to_float(-0.250),to_float(0.625),to_float(0.000),to_float(-0.375),to_float(-0.875),to_float(-0.875),to_float(-0.750),to_float(0.875),to_float(0.375)),
(to_float(-0.875),to_float(0.875),to_float(0.875),to_float(0.750),to_float(-0.875),to_float(0.125),to_float(0.000),to_float(0.750),to_float(0.375),to_float(-0.875)),
(to_float(0.875),to_float(-0.875),to_float(0.250),to_float(-0.875),to_float(-0.125),to_float(0.875),to_float(-0.500),to_float(0.500),to_float(0.375),to_float(-0.875)),
(to_float(-0.375),to_float(-0.375),to_float(0.875),to_float(0.875),to_float(-0.875),to_float(-0.250),to_float(-0.875),to_float(0.875),to_float(-0.875),to_float(-0.875)),
(to_float(-0.375),to_float(0.875),to_float(-0.500),to_float(-0.125),to_float(0.625),to_float(0.500),to_float(0.375),to_float(0.125),to_float(-0.875),to_float(-0.875)),
(to_float(-0.125),to_float(-0.625),to_float(0.500),to_float(-0.375),to_float(0.875),to_float(0.000),to_float(0.250),to_float(-0.750),to_float(-0.875),to_float(0.625)),
(to_float(-0.250),to_float(-0.875),to_float(-0.625),to_float(0.875),to_float(-0.875),to_float(0.750),to_float(-0.875),to_float(0.875),to_float(0.125),to_float(0.625)),
(to_float(0.875),to_float(0.125),to_float(0.500),to_float(-0.875),to_float(-0.875),to_float(-0.875),to_float(-0.250),to_float(-0.125),to_float(0.625),to_float(0.500)));
 
end mulmat_soft_mem;