----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/02/2023 12:16:07 PM
-- Design Name: 
-- Module Name: top - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
    Port ( clk : in STD_LOGIC;
           btn : in std_logic_vector(3 downto 0) ;
           sw : in std_logic ;
           rows : in std_logic_vector (3 downto 0);
           cols : out std_logic_vector (3 downto 0);
           digit   :out std_logic ;
           seg : out std_logic_vector (6 downto 0));
end top;

architecture Behavioral of top is
signal int_ones: std_logic_vector  (3 downto 0);
signal int_val_in: std_logic_vector  (3 downto 0);
signal int_clk : std_logic; 
signal int_reset: std_logic ;
signal int_val: std_logic ;
signal int_dir : std_logic;
signal int_dir_in : std_logic;
signal int_decout: std_logic_vector (3 downto 0);
signal int_en : std_logic ;


component clock_div
port (clock : in STD_LOGIC;
       	div : out STD_LOGIC);
end component;

component debounce
port (button : in STD_LOGIC;
       	clock : in STD_LOGIC;
       	debounce : out STD_LOGIC);
end component;
    
component digits
port (   clk : in  std_logic;
        clock_en : in std_logic ;
        reset : in  std_logic;
        en : in std_logic;
        ld : in STD_LOGIC;
        one_in: in std_logic_vector (3 downto 0);
        dir : in std_logic;
        updn : in STD_LOGIC;
        ones : out std_logic_vector(3 downto 0)
       );
   
end component;
    


component decoder
port ( clk : in STD_LOGIC;
         row : in std_logic_vector (3 downto 0);
          col : out std_logic_vector (3 downto 0);
           dec_out : out std_logic_vector (3 downto 0));
end component;

component seg7_control
port (  clk : in std_logic; 
        
            reset : in std_logic;
            ones : in std_logic_vector (3 downto 0);
            
            
            digit  : out std_logic;
            seg : out std_logic_vector (6 downto 0));
end component;

begin

--process(clk)
--    begin
--        if rising_edge(clk) then
--            if int_val = '1' then
--             int_val_in <= int_decout;
--            end if;
--            if int_dir ='1' then
--             int_dir_in<= int_decout;
--            end if;
--        end if;
        
--end process;



a1: clock_div
port map(clock=>clk, div=>int_clk);
a2: digits
port map(clk => clk , clock_en => int_clk,  reset=> int_reset, en => int_en, ld => int_val, one_in=> int_decout,  dir => sw,updn=>int_dir , ones =>int_ones);  
a3: decoder 
port map(clk=>clk,row => rows, col=> cols, dec_out=>int_decout);

a4: seg7_control
port map(clk => clk, reset=> int_reset, ones => int_ones, digit=> digit, seg=>seg);
a5: debounce
port map(button => btn(0) , clock => clk, debounce=>int_reset);
a6: debounce
port map(button => btn(1) , clock => clk, debounce=>int_val);

a7: debounce
port map(button => btn(2) , clock => clk, debounce=>int_dir);
a8: debounce
port map(button => btn(3) , clock => clk, debounce=>int_en);

end Behavioral;
