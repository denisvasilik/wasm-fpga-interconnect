library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.NUMERIC_STD.all;

library work;
use work.tb_types.all;

entity tb_WasmFpgaInterconnect is
    generic (
        stimulus_path : string := "../../../../../simstm/";
        stimulus_file : string := "WasmFpgaInterconnect.stm"
    );
end;

architecture behavioural of tb_WasmFpgaInterconnect is

    constant CLK100M_PERIOD : time := 10 ns;

    signal Clk100M : std_logic := '0';
    signal Rst : std_logic := '1';
    signal nRst : std_logic := '0';

    signal WasmFpgaInterconnect_FileIo : T_WasmFpgaInterconnect_FileIo;
    signal FileIo_WasmFpgaInterconnect : T_FileIo_WasmFpgaInterconnect;

    component tb_FileIo is
        generic (
            stimulus_path: in string;
            stimulus_file: in string
        );
        port (
            Clk : in std_logic;
            Rst : in std_logic;
            WasmFpgaInterconnect_FileIo : in T_WasmFpgaInterconnect_FileIo;
            FileIo_WasmFpgaInterconnect : out T_FileIo_WasmFpgaInterconnect
        );
    end component;

    component WasmFpgaInterconnect
      port (
        Loaded : in std_logic;
        Loader_Adr : in std_logic_vector(23 downto 0);
        Loader_Sel : in std_logic_vector(3 downto 0);
        Loader_DatIn : in std_logic_vector(31 downto 0);
        Loader_We : in std_logic;
        Loader_Stb : in std_logic;
        Loader_Cyc : in std_logic_vector(0 downto 0);
        Loader_DatOut : out std_logic_vector(31 downto 0);
        Loader_Ack : out std_logic;
        Adr : in std_logic_vector(23 downto 0);
        Sel : in std_logic_vector(3 downto 0);
        DatIn : in std_logic_vector(31 downto 0); 
        We : in std_logic;
        Stb : in std_logic;
        Cyc : in std_logic_vector(0 downto 0);
        DatOut : out std_logic_vector(31 downto 0);
        Ack : out std_logic;
        Memory_Adr : out std_logic_vector(23 downto 0);
        Memory_Sel : out std_logic_vector(3 downto 0);
        Memory_DatIn: in std_logic_vector(31 downto 0);
        Memory_We : out std_logic;
        Memory_Stb : out std_logic;
        Memory_Cyc : out std_logic_vector(0 downto 0);
        Memory_DatOut : out std_logic_vector(31 downto 0);
        Memory_Ack : in std_logic
      );
    end component;

begin

	nRst <= not Rst;

    Clk100MGen : process is
    begin
        Clk100M <= not Clk100M;
        wait for CLK100M_PERIOD / 2;
    end process;

    RstGen : process is
    begin
        Rst <= '1';
        wait for 100ns;
        Rst <= '0';
        wait;
    end process;

    tb_FileIo_i : tb_FileIo
        generic map (
            stimulus_path => stimulus_path,
            stimulus_file => stimulus_file
        )
        port map (
            Clk => Clk100M,
            Rst => Rst,
            WasmFpgaInterconnect_FileIo => WasmFpgaInterconnect_FileIo,
            FileIo_WasmFpgaInterconnect => FileIo_WasmFpgaInterconnect
        );

    WasmFpgaInterconnect_i : WasmFpgaInterconnect
      port map (
        Loaded => FileIo_WasmFpgaInterconnect.Loaded,
        Loader_Adr => FileIo_WasmFpgaInterconnect.Loader_Adr,
        Loader_Sel => FileIo_WasmFpgaInterconnect.Loader_Sel,
        Loader_DatIn => FileIo_WasmFpgaInterconnect.Loader_DatIn,
        Loader_We => FileIo_WasmFpgaInterconnect.Loader_We,
        Loader_Stb => FileIo_WasmFpgaInterconnect.Loader_Stb,
        Loader_Cyc => FileIo_WasmFpgaInterconnect.Loader_Cyc,
        Loader_DatOut => WasmFpgaInterconnect_FileIo.Loader_DatOut,
        Loader_Ack => WasmFpgaInterconnect_FileIo.Loader_Ack,
        Adr => FileIo_WasmFpgaInterconnect.Adr,
        Sel => FileIo_WasmFpgaInterconnect.Sel,
        DatIn => FileIo_WasmFpgaInterconnect.DatIn,
        We => FileIo_WasmFpgaInterconnect.We,
        Stb => FileIo_WasmFpgaInterconnect.Stb,
        Cyc => FileIo_WasmFpgaInterconnect.Cyc,
        DatOut => WasmFpgaInterconnect_FileIo.DatOut,
        Ack => WasmFpgaInterconnect_FileIo.Ack,
        Memory_Adr => WasmFpgaInterconnect_FileIo.Memory_Adr,
        Memory_Sel => WasmFpgaInterconnect_FileIo.Memory_Sel,
        Memory_DatIn => FileIo_WasmFpgaInterconnect.Memory_DatIn,
        Memory_We => WasmFpgaInterconnect_FileIo.Memory_We,
        Memory_Stb => WasmFpgaInterconnect_FileIo.Memory_Stb,
        Memory_Cyc => WasmFpgaInterconnect_FileIo.Memory_Cyc,
        Memory_DatOut => WasmFpgaInterconnect_FileIo.Memory_DatOut,
        Memory_Ack => FileIo_WasmFpgaInterconnect.Memory_Ack
      );

end;
