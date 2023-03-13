library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fixed_fir is
    Port ( clk_i : in STD_LOGIC;
           u_i : in STD_LOGIC_VECTOR (23 downto 0);
           y_o : out STD_LOGIC_VECTOR (23 downto 0));
end fixed_fir;

architecture Behavioral of fixed_fir is
    type std_2d is array (4 downto 0) of std_logic_vector(47 downto 0);
    signal mac_inter : std_2d := (others=>(others=>'0'));
    
    type coef_t is array (0 to 4) of std_logic_vector(23 downto 0);
    signal b : coef_t := (x"18bfcb",
                          x"1a05d9",
                          x"1a74b5",
                          x"1a05d9",
                          x"18bfcb");
begin

    prvi_MAC:
    entity work.mac(behavioral)
    port map(clk_i=>clk_i,
             u_i=>u_i,
             b_i=>b(4),
             mac_i=>(others=>'0'),
             mac_o=>mac_inter(0));
    
    drugi_MAC:
    entity work.mac(behavioral)
    port map(clk_i=>clk_i,
             u_i=>u_i,
             b_i=>b(3),
             mac_i=>mac_inter(0),
             mac_o=>mac_inter(1));
                              
    treci_MAC:
    entity work.mac(behavioral)
    port map(clk_i=>clk_i,
             u_i=>u_i,
             b_i=>b(2),
             mac_i=>mac_inter(1),
             mac_o=>mac_inter(2));
       
    cetvrti_MAC:
    entity work.mac(behavioral)
    port map(clk_i=>clk_i,
             u_i=>u_i,
             b_i=>b(1),
             mac_i=>mac_inter(2),
             mac_o=>mac_inter(3));

    peti_MAC:
    entity work.mac(behavioral)
    port map(clk_i=>clk_i,
             u_i=>u_i,
             b_i=>b(0),
             mac_i=>mac_inter(3),
             mac_o=>mac_inter(4));
             
    y_o <= mac_inter(4)(46 downto 23);
             
end Behavioral;