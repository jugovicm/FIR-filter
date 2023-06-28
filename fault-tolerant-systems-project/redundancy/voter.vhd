library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_misc.all;
use work.dsong_pkg.all;

entity voter is
    generic(num_units: integer := 5;
            size: integer := 24);
    port(clk: in std_logic;
         rst: in std_logic;
         c_esw: in std_logic_vector(num_units*size-1 downto 0);
         c_vot: out std_logic_vector(size-1 downto 0));
end voter;

architecture Behavioral of voter is
    component voter_logic
    generic(size: integer := 8);
    port(data_in_1: in std_logic_vector(size-1 downto 0);
         data_in_2: in std_logic_vector (size-1 downto 0);
         data_in_3: in std_logic_vector (size-1 downto 0);
         data_out: out std_logic_vector (size-1 downto 0));
    end component voter_logic;
    
    constant comb: integer := comb(num_units, 3);
    
    type dir_array is array(comb-1 downto 0) of std_logic_vector(size-1 downto 0);
    type inv_array is array(size-1 downto 0) of std_logic_vector(comb-1 downto 0);
    
    signal temp: dir_array;
    signal swapped: inv_array;
begin
    gen_maj3_0: for i in 0 to num_units-3 generate
        gen_maj3_1: for j in (i+1) to num_units-2 generate
            gen_maj_2: for k in (j+1) to num_units-1 generate
                unit_maj: voter_logic generic map(size => size)
                            port map(data_in_1 => c_esw((i+1)*size-1 downto i*size),
                                       data_in_2 => c_esw((j+1)*size-1 downto j*size),
                                       data_in_3 => c_esw((k+1)*size-1 downto k*size),
                                       data_out => temp(math_map(i,j,k,num_units)));
            end generate;
        end generate;
    end generate;
    
    swap: process(temp)
    begin
        for i in 0 to comb-1 loop
            for j in size-1 downto 0 loop
                swapped(j)(i) <= temp(i)(j);
            end loop;
        end loop;
    end process;

    set: process(swapped)
    begin
        for i in size-1 downto 0 loop
            c_vot(i) <= or_reduce(swapped(i));
        end loop;
    end process;
end Behavioral;
