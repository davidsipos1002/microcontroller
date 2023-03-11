library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity PROGRAM_COUNTER is
    Port(R : in STD_LOGIC;
         D : in STD_LOGIC_VECTOR (7 downto 0);
         CLK : in STD_LOGIC;
         PL : in STD_LOGIC;
         Q : out STD_LOGIC_VECTOR (7 downto 0));
end PROGRAM_COUNTER;

architecture PC of PROGRAM_COUNTER is

    component T_FLIP_FLOP is
        Port(R : in STD_LOGIC;
             T : in STD_LOGIC;
             CLK:in STD_LOGIC;
             Q:out STD_LOGIC);
    end component;

    component MUX_21 is
        Port(I0 : in STD_LOGIC;
             I1 : in STD_LOGIC;
             S:in STD_LOGIC;
             Y:out STD_LOGIC);
    end component;

    signal AINT : STD_LOGIC_VECTOR(0 to 6);
    signal T : STD_LOGIC_VECTOR(0 to 7);
    signal X : STD_LOGIC_VECTOR (0 to 7);
    signal OUT_Q : STD_LOGIC_VECTOR (7 downto 0);

begin
    X(0) <= D(0) xor OUT_Q(0);
    MUX0: MUX_21 port map('1', X(0), PL, T(0));
    TFF0: T_FLIP_FLOP port map(R, T(0), CLK, OUT_Q(0));

    X(1) <= D(1) xor OUT_Q(1);
    AINT(0) <= OUT_Q(0);
    MUX1: MUX_21 port map(AINT(0), X(1), PL, T(1));
    TFF1: T_FLIP_FLOP port map(R, T(1), CLK, OUT_Q(1));

    X(2) <= D(2) xor OUT_Q(2);
    AINT(1) <= AINT(0) and OUT_Q(1);
    MUX2: MUX_21 port map(AINT(1), X(2), PL, T(2));
    TFF2: T_FLIP_FLOP port map(R, T(2), CLK, OUT_Q(2));

    X(3) <= D(3) xor OUT_Q(3);
    AINT(2) <= AINT(1) and OUT_Q(2);
    MUX3: MUX_21 port map(AINT(2), X(3), PL, T(3));
    TFF3: T_FLIP_FLOP port map(R, T(3), CLK, OUT_Q(3));

    X(4) <= D(4) xor OUT_Q(4);
    AINT(3) <= AINT(2) and OUT_Q(3);
    MUX4: MUX_21 port map(AINT(3), X(4), PL, T(4));
    TFF4: T_FLIP_FLOP port map(R, T(4), CLK, OUT_Q(4));

    X(5) <= D(5) xor OUT_Q(5);
    AINT(4) <= AINT(3) and OUT_Q(4);
    MUX5: MUX_21 port map(AINT(4), X(5), PL, T(5));
    TFF5: T_FLIP_FLOP port map(R, T(5), CLK, OUT_Q(5));

    X(6) <= D(6) xor OUT_Q(6);
    AINT(5) <= AINT(4) and OUT_Q(5);
    MUX6: MUX_21 port map(AINT(5), X(6), PL, T(6));
    TFF6: T_FLIP_FLOP port map(R, T(6), CLK, OUT_Q(6));

    X(7) <= D(7) xor OUT_Q(7);
    AINT(6) <= AINT(5) and OUT_Q(6);
    MUX7: MUX_21 port map(AINT(6), X(7), PL, T(7));
    TFF7: T_FLIP_FLOP port map(R, T(7), CLK, OUT_Q(7));

    Q <= OUT_Q;
end PC;
