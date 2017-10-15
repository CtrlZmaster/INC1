-- fsm.vhd: Finite State Machine
-- Author(s): Michal Pospíšil (xpospi95 "at" vutbr.cz)
--
library ieee;
use ieee.std_logic_1164.all;
-- ----------------------------------------------------------------------------
--                        Entity declaration
-- ----------------------------------------------------------------------------
entity fsm is
port(
   CLK         : in  std_logic;
   RESET       : in  std_logic;

   -- Input signals
   KEY         : in  std_logic_vector(15 downto 0);
   CNT_OF      : in  std_logic;

   -- Output signals
   FSM_CNT_CE  : out std_logic;
   FSM_MX_MEM  : out std_logic;
   FSM_MX_LCD  : out std_logic;
   FSM_LCD_WR  : out std_logic;
   FSM_LCD_CLR : out std_logic
);
end entity fsm;

-- ----------------------------------------------------------------------------
--                      Architecture declaration
-- K1 = 1700146915 K2 = 1550220373
-- ----------------------------------------------------------------------------
architecture behavioral of fsm is
   type t_state is (TEST_BOTH_0, 
	                 TEST_BOTH_1, 
						  TEST_C1_2, TEST_C2_2, 
						  TEST_C1_3, TEST_C2_3, 
						  TEST_C1_4, TEST_C2_4, 
						  TEST_C1_5, TEST_C2_5, 
						  TEST_C1_6, TEST_C2_6, 
						  TEST_C1_7, TEST_C2_7, 
						  TEST_C1_8, TEST_C2_8, 
						  TEST_C1_9, TEST_C2_9,
                    TEST_OK, TEST_FAIL,						  
						  PRINT_SUCCESS, PRINT_FAIL, 
						  FINISH);
   signal present_state, next_state : t_state;

begin
-- -------------------------------------------------------
sync_logic : process(RESET, CLK)
begin
   if (RESET = '1') then
      present_state <= TEST_BOTH_0;
   elsif (CLK'event AND CLK = '1') then
      present_state <= next_state;
   end if;
end process sync_logic;

-- -------------------------------------------------------
next_state_logic : process(present_state, KEY, CNT_OF)
begin
   case (present_state) is
   -- - - - - - - - - - - - - - - - - - - - - - -
   when TEST_BOTH_0 =>
      next_state <= TEST_BOTH_0;
      if (KEY(1) = '1') then
         next_state <= TEST_BOTH_1; 
		elsif (KEY(15) = '1') then
			next_state <= PRINT_FAIL;
			elsif KEY(15 downto 0) /= "0000000000000000" then
				next_state <= TEST_FAIL;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
	when TEST_BOTH_1 =>
      next_state <= TEST_BOTH_1;
      if (KEY(5) = '1') then
         next_state <= TEST_C2_2; 
		elsif (KEY(7) = '1') then
			next_state <= TEST_C1_2;
			elsif (KEY(15) = '1') then
				next_state <= PRINT_FAIL;
					elsif KEY(15 downto 0) /= "0000000000000000" then
						next_state <= TEST_FAIL;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
	when TEST_C1_2 =>
      next_state <= TEST_C1_2;
      if (KEY(0) = '1') then
         next_state <= TEST_C1_3; 
		elsif (KEY(15) = '1') then
			next_state <= PRINT_FAIL;
			elsif KEY(15 downto 0) /= "0000000000000000" then
				next_state <= TEST_FAIL;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
	when TEST_C1_3 =>
      next_state <= TEST_C1_3;
      if (KEY(0) = '1') then
         next_state <= TEST_C1_4; 
		elsif (KEY(15) = '1') then
			next_state <= PRINT_FAIL;
			elsif KEY(15 downto 0) /= "0000000000000000" then
				next_state <= TEST_FAIL;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
	when TEST_C1_4 =>
      next_state <= TEST_C1_4;
      if (KEY(1) = '1') then
         next_state <= TEST_C1_5; 
		elsif (KEY(15) = '1') then
			next_state <= PRINT_FAIL;
			elsif KEY(15 downto 0) /= "0000000000000000" then
				next_state <= TEST_FAIL;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
	when TEST_C1_5 =>
      next_state <= TEST_C1_5;
      if (KEY(4) = '1') then
         next_state <= TEST_C1_6; 
		elsif (KEY(15) = '1') then
			next_state <= PRINT_FAIL;
			elsif KEY(15 downto 0) /= "0000000000000000" then
				next_state <= TEST_FAIL;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
	when TEST_C1_6 =>
      next_state <= TEST_C1_6;
      if (KEY(6) = '1') then
         next_state <= TEST_C1_7; 
		elsif (KEY(15) = '1') then
			next_state <= PRINT_FAIL;
			elsif KEY(15 downto 0) /= "0000000000000000" then
				next_state <= TEST_FAIL;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
	when TEST_C1_7 =>
      next_state <= TEST_C1_7;
      if (KEY(9) = '1') then
         next_state <= TEST_C1_8; 
		elsif (KEY(15) = '1') then
			next_state <= PRINT_FAIL;
			elsif KEY(15 downto 0) /= "0000000000000000" then
				next_state <= TEST_FAIL;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
	when TEST_C1_8 =>
      next_state <= TEST_C1_8;
      if (KEY(1) = '1') then
         next_state <= TEST_C1_9; 
		elsif (KEY(15) = '1') then
			next_state <= PRINT_FAIL;
			elsif KEY(15 downto 0) /= "0000000000000000" then
				next_state <= TEST_FAIL;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
	when TEST_C1_9 =>
      next_state <= TEST_C1_9;
      if (KEY(5) = '1') then
         next_state <= TEST_OK; 
		elsif (KEY(15) = '1') then
			next_state <= PRINT_FAIL;
			elsif KEY(15 downto 0) /= "0000000000000000" then
				next_state <= TEST_FAIL;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   -- TESTING CODE 2
	-- - - - - - - - - - - - - - - - - - - - - - -	
	when TEST_C2_2 =>
      next_state <= TEST_C2_2;
      if (KEY(5) = '1') then
         next_state <= TEST_C2_3; 
		elsif (KEY(15) = '1') then
			next_state <= PRINT_FAIL;
			elsif KEY(15 downto 0) /= "0000000000000000" then
				next_state <= TEST_FAIL;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
	when TEST_C2_3 =>
      next_state <= TEST_C2_3;
      if (KEY(0) = '1') then
         next_state <= TEST_C2_4; 
		elsif (KEY(15) = '1') then
			next_state <= PRINT_FAIL;
			elsif KEY(15 downto 0) /= "0000000000000000" then
				next_state <= TEST_FAIL;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
	when TEST_C2_4 =>
      next_state <= TEST_C2_4;
      if (KEY(2) = '1') then
         next_state <= TEST_C2_5; 
		elsif (KEY(15) = '1') then
			next_state <= PRINT_FAIL;
			elsif KEY(15 downto 0) /= "0000000000000000" then
				next_state <= TEST_FAIL;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
	when TEST_C2_5 =>
      next_state <= TEST_C2_5;
      if (KEY(2) = '1') then
         next_state <= TEST_C2_6; 
		elsif (KEY(15) = '1') then
			next_state <= PRINT_FAIL;
			elsif KEY(15 downto 0) /= "0000000000000000" then
				next_state <= TEST_FAIL;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
	when TEST_C2_6 =>
      next_state <= TEST_C2_6;
      if (KEY(0) = '1') then
         next_state <= TEST_C2_7; 
		elsif (KEY(15) = '1') then
			next_state <= PRINT_FAIL;
			elsif KEY(15 downto 0) /= "0000000000000000" then
				next_state <= TEST_FAIL;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
	when TEST_C2_7 =>
      next_state <= TEST_C2_7;
      if (KEY(3) = '1') then
         next_state <= TEST_C2_8; 
		elsif (KEY(15) = '1') then
			next_state <= PRINT_FAIL;
			elsif KEY(15 downto 0) /= "0000000000000000" then
				next_state <= TEST_FAIL;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
	when TEST_C2_8 =>
      next_state <= TEST_C2_8;
      if (KEY(7) = '1') then
         next_state <= TEST_C2_9; 
		elsif (KEY(15) = '1') then
			next_state <= PRINT_FAIL;
			elsif KEY(15 downto 0) /= "0000000000000000" then
				next_state <= TEST_FAIL;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
	when TEST_C2_9 =>
      next_state <= TEST_C2_9;
      if (KEY(3) = '1') then
         next_state <= TEST_OK;
		elsif (KEY(15) = '1') then
			next_state <= PRINT_FAIL;
			elsif KEY(15 downto 0) /= "0000000000000000" then
				next_state <= TEST_FAIL;
      end if;
	-- - - - - - - - - - - - - - - - - - - - - - -
   when TEST_OK =>
      next_state <= TEST_OK;
      if (KEY(15) = '1') then
         next_state <= PRINT_SUCCESS;
		elsif KEY(15 downto 0) /= "0000000000000000" then
			next_state <= TEST_FAIL;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
	when TEST_FAIL =>
      next_state <= TEST_FAIL;
      if (KEY(15) = '1') then
         next_state <= PRINT_FAIL;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when PRINT_SUCCESS =>
      next_state <= PRINT_SUCCESS;
      if (CNT_OF = '1') then
         next_state <= FINISH;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
	when PRINT_FAIL =>
      next_state <= PRINT_FAIL;
      if (CNT_OF = '1') then
         next_state <= FINISH;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when FINISH =>
      next_state <= FINISH;
      if (KEY(15) = '1') then
         next_state <= TEST_BOTH_0; 
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when others =>
      next_state <= TEST_BOTH_0;
   end case;
end process next_state_logic;

-- -------------------------------------------------------
output_logic : process(present_state, KEY)
begin
   FSM_CNT_CE     <= '0';
   FSM_MX_MEM     <= '0';
   FSM_MX_LCD     <= '0';
   FSM_LCD_WR     <= '0';
   FSM_LCD_CLR    <= '0';

   case (present_state) is
   -- - - - - - - - - - - - - - - - - - - - - - -
   when TEST_BOTH_0|TEST_BOTH_1|TEST_C1_2|TEST_C2_2|TEST_C1_3|TEST_C2_3|TEST_C1_4|TEST_C2_4| 
		  TEST_C1_5|TEST_C2_5|TEST_C1_6|TEST_C2_6|TEST_C1_7|TEST_C2_7|TEST_C1_8|TEST_C2_8|
		  TEST_C1_9|TEST_C2_9|TEST_OK|TEST_FAIL =>
      if (KEY(14 downto 0) /= "000000000000000") then
         FSM_LCD_WR     <= '1';
      end if;
      if (KEY(15) = '1') then
         FSM_LCD_CLR    <= '1';
      end if;
	-- - - - - - - - - - - - - - - - - - - - - - -
   when PRINT_SUCCESS =>
		FSM_MX_MEM		<= '1';
		FSM_CNT_CE     <= '1';
      FSM_MX_LCD     <= '1';
      FSM_LCD_WR     <= '1';
   -- - - - - - - - - - - - - - - - - - - - - - -
	when PRINT_FAIL =>
		FSM_MX_MEM		<= '0';
		FSM_CNT_CE     <= '1';
      FSM_MX_LCD     <= '1';
      FSM_LCD_WR     <= '1';
   -- - - - - - - - - - - - - - - - - - - - - - -
   when FINISH =>
      if (KEY(15) = '1') then
         FSM_LCD_CLR    <= '1';
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when others =>
   end case;
end process output_logic;

end architecture behavioral;

