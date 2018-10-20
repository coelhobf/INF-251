// 65255 - Westerley Carvalho Oliveira
// 92559 - Bruno Ferreira Coelho

/* Maquina de vendas, nao devolve troco e vende um produto de 40 reais.
A maquina que testa a maquina de vendas, envia somente uma moeda por vez quando
o sinal NEXT faz uma transicao de 0->1. A Maquina de Venda que irá controlar o sinal 
NEXT. A Maquina de "compra" vai enviando as moedas uma por uma, sincronizando o 
sinal Next e incrementando o endereco da proxima moeda. Quando o Sinal vendeu for
1, a maquina de compra espera a maquina de venda baixar o sinal de vendas para 
continuar a comprar com a sequencia que está na memoria.
As duas maquinas voce fará usando o alto nível de Verilog com diagrama de estados em 
CASE. A Memoria é somente um modulo de memoria com CLK. 
Dica: usar um contador, registradores, comparadores e somadores para facilitar o diagrama
de estados das duas maquinas. */

module memoria (input clk, input [3:0] line, input reset, output [1:0] saida);
  
    // Memória com 16 linhas de 2 bits
    reg [1:0] memory[0:15];
    reg [1:0] dout;

    always @ (posedge clk)
    begin 
        dout <= memory[line];
    end

    always @ (posedge reset) 
    begin
        if(reset)
        begin
            memory[0]  <= 2'd0;
            memory[1]  <= 2'd1;
            memory[2]  <= 2'd2;
            memory[3]  <= 2'd0;
            memory[4]  <= 2'd1;
            memory[5]  <= 2'd2;
            memory[6]  <= 2'd0;
            memory[7]  <= 2'd1;
            memory[8]  <= 2'd2;
            memory[9]  <= 2'd0;
            memory[10] <= 2'd1;
            memory[11] <= 2'd2;
            memory[12] <= 2'd0;
            memory[13] <= 2'd1;
            memory[14] <= 2'd2;
            memory[15] <= 2'd0;
        end
    end

    assign saida = dout;

endmodule

module maquinaMoedas(input clk, input reset, input vendeu, output [1:0]saida);

    reg [3:0] nextLine = 4'd0;

    wire newClock;
    assign newClock = ~vendeu && clk;

    memoria mem(newClock, nextLine, reset, saida);

    always @(posedge newClock)
    begin
        nextLine <= nextLine + 1;
    end
    
    always @(negedge reset)
    begin
        nextLine <= 4'd0;
    end    

endmodule

module soma(input clk, input [5:0] a, input [1:0] b, output [5:0] saida);

    reg [5:0] c = 6'd0;

    always@ (posedge clk)
    begin
        case (b)
            2'd0: c <= a + 6'd5;
            2'd1: c <= a + 6'd10;
            2'd2: c <= a + 6'd20;
        endcase
    end

    assign saida = c;

endmodule

module compara(input clk, input [5:0] a, output saida);

    reg b = 1'd0;
    always@ (posedge clk)
    begin
        b <= (a >= 6'd40) ? 1'd1 : 1'd0;
    end

    assign saida = b;

endmodule

module flipflop (input clk, input [5:0] data, input naoVendeu, output [5:0] saida);
    
    reg [5:0] q = 6'd0;

    always @(posedge clk or negedge naoVendeu) 
    begin
        q <= data; 
        if (naoVendeu == 1'b0)
            q <= 6'd0;  
    end

    assign saida = q;

endmodule

module maquinaVendas(input clk, input [1:0] moeda, input reset, output saida);

    wire [5:0] saldo;
    wire [5:0] newSaldo;
    wire vendeu;

    soma s1(clk, saldo, moeda,
        newSaldo);
    
    flipflop f1(clk, newSaldo, ~vendeu,
        saldo);
    
    compara c1(clk, saldo,
        vendeu);

    assign saida = vendeu;

endmodule

module main;

    reg clk;
    reg reset;

    wire vendeu;
    wire [1:0] moeda;

    maquinaMoedas m1(clk, reset, vendeu,    // entradas
        moeda);                             // saidas
    
    maquinaVendas m2(clk, moeda, reset,     // entradas
        vendeu);                            // saidas

    initial 
        clk = 1'b0;
    always
        clk = #(1) ~clk;

    // visualizar formas de onda usar gtkwave out.vcd
    initial  begin
        $dumpfile ("out.vcd"); 
        $dumpvars; 
    end 

    initial 
        begin
            $monitor($time," Clock: %b Vendeu %b Moeda: %b", clk, vendeu, moeda);
            #1 reset = 0;
            #1 reset = 1;
            #32;
            $finish ;
        end

endmodule