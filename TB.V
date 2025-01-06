library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_memory_VHDL is
end tb_memory_VHDL;

architecture Behavioral of tb_memory_VHDL is

    -- Component Declaration for memory_VHDL
    component memory_VHDL
        Port (
            clkA       : in  STD_LOGIC;
            rstA       : in  STD_LOGIC;
            wr_enA     : in  STD_LOGIC;
            wr_addrA   : in  STD_LOGIC_VECTOR (9 downto 0);
            wr_dataA   : in  STD_LOGIC_VECTOR (15 downto 0);
            clkB       : in  STD_LOGIC;
            rstB       : in  STD_LOGIC;
            rd_enB     : in  STD_LOGIC;
            rd_addrB   : in  STD_LOGIC_VECTOR (9 downto 0);
            rd_dataB   : out STD_LOGIC_VECTOR (15 downto 0);
            rd_validB  : out STD_LOGIC
        );
    end component;

    -- Testbench Signals
    signal clkA       : STD_LOGIC := '0';
    signal rstA       : STD_LOGIC := '0';
    signal wr_enA     : STD_LOGIC := '0';
    signal wr_addrA   : STD_LOGIC_VECTOR (9 downto 0) := (others => '0');
    signal wr_dataA   : STD_LOGIC_VECTOR (15 downto 0) := (others => '0');
    signal clkB       : STD_LOGIC := '0';
    signal rstB       : STD_LOGIC := '0';
    signal rd_enB     : STD_LOGIC := '0';
    signal rd_addrB   : STD_LOGIC_VECTOR (9 downto 0) := (others => '0');
    signal rd_dataB   : STD_LOGIC_VECTOR (15 downto 0);
    signal rd_validB  : STD_LOGIC;

    -- Clock Period Constants
    constant clk_periodA : time := 10 ns;
    constant clk_periodB : time := 10 ns;

begin

    -- Instantiate the DUT (Device Under Test)
    uut: memory_VHDL
        Port Map (
            clkA       => clkA,
            rstA       => rstA,
            wr_enA     => wr_enA,
            wr_addrA   => wr_addrA,
            wr_dataA   => wr_dataA,
            clkB       => clkB,
            rstB       => rstB,
            rd_enB     => rd_enB,
            rd_addrB   => rd_addrB,
            rd_dataB   => rd_dataB,
            rd_validB  => rd_validB
        );

    -- Clock Generation for clkA
    clkA_process : process
    begin
        clkA <= '0';
        wait for clk_periodA / 2;
        clkA <= '1';
        wait for clk_periodA / 2;
    end process;

    -- Clock Generation for clkB
    clkB_process : process
    begin
        clkB <= '0';
        wait for clk_periodB / 2;
        clkB <= '1';
        wait for clk_periodB / 2;
    end process;

    -- Stimulus Process to simulate input values
    stimulus: process
        variable write_data : STD_LOGIC_VECTOR(15 downto 0);
        variable address    : integer := 0;
    begin
        -- Reset the system
        rstA <= '1';
        rstB <= '1';
        wait for clk_periodA;
        rstA <= '0';
        rstB <= '0';
        wait for clk_periodA;

        -- Write data to multiple memory locations
        for address in 0 to 5 loop
            wr_enA <= '1';
            wr_addrA <= std_logic_vector(to_unsigned(address, 10));
            write_data := std_logic_vector(to_unsigned(address * 16#10#, 16));  -- Data pattern: 10, 20, 30, etc.
            wr_dataA <= write_data;
            wait for clk_periodA;
        end loop;
        wr_enA <= '0';
        wait for clk_periodA;

        -- Read data from the written memory locations
        for address in 0 to 5 loop
            rd_enB <= '1';
            rd_addrB <= std_logic_vector(to_unsigned(address, 10));
            wait for clk_periodB;
            -- Assert that the read data is correct (match the expected value)
            assert rd_dataB = std_logic_vector(to_unsigned(address * 16#10#, 16))
                report "Read Error at address: " & integer'image(address) severity error;
        end loop;
        rd_enB <= '0';
        wait for clk_periodB;

        -- Check memory invalid address read (should output invalid data)
        rd_enB <= '1';
        rd_addrB <= "1111111111";  -- Address beyond the range (invalid)
        wait for clk_periodB;
        assert rd_validB = '0'
            report "Unexpected valid data for invalid address" severity warning;
        rd_enB <= '0';
        wait for clk_periodB;

        -- End Simulation
        wait;
    end process;

end Behavioral;
