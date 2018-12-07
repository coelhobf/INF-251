## Questão 4 do trabalho 4

### Grupo: Armando, Bruno, Roger, Westerley

#### Parte 1:

Para resolver a primeira parte foi adicionado o seguinte trecho de código.

- Se a comparação do beq será verdadeira no 2º estagio. Se sim troca o pc + 4;
- Para remover o beq de 4º estágio setar o flush_s3 para verdadeiro

```verilog
wire c;
reg [31:0] pc4_;
assign c = branch_eq_s2 & ~(data1 - data2) | branch_ne_s2 & (data1-data2);
always @(*)
//if(c == 1'b1)
begin
    if(c == 1'b1)
    begin
        pc4_ <= baddr_s2;
    end
    else
    begin
        pc4_ <= pc + 4;
    end
end
assign pc4 = pc4_;

// flush de segundo estagio
always @(*) begin
    flush_s1 <= 1'b0;
    flush_s2 <= 1'b0;
    flush_s3 <= 1'b0;
    if (c == 1'b1) begin
        flush_s1 <= 1'b1;
        flush_s2 <= 1'b1;
        flush_s3 <= 1'b0;
    end
end
// }}}
```

#### Parte 2:

Para a 2ª parte foi adicionado esse codigo

- Verifica se algum dos registradores a ser lido será escrito
- Faz um and com o sinal de escrever em registrador
- Se verdadeiro subistitui a entrada do beq para essa saida

```verilog
// Parte b
wire alu_d1;
wire alu_d2;
assign alu_d1 = (rs - wrreg_s4 == 5'd0) ? 1'b1 : 1'b0;
assign alu_d2 = (rt - wrreg_s4 == 5'd0) ? 1'b1 : 1'b0;

wire control_d1;
wire control_d2;
assign control_d1 = regwrite_s4 & alu_d1;
assign control_d2 = regwrite_s4 & alu_d2;

wire [31:0] m1;
wire [31:0] m2;
assign m1 = (control_d1 == 1'b1) ? alu_d1 : data1;
assign m2 = (control_d2 == 1'b1) ? alu_d2 : data2;

// parte a, beq de 2º estagio
wire c;
reg [31:0] pc4_;
assign c = branch_eq_s2 & ~(m1 - m2) | branch_ne_s2 & (m1-m2);
```

#### Parte 3:

Nesta parte foi adiconado o seguinte trecho de cógido

- Se algum dos controllers da parte 2 for verdadeiro, faz um flush e stall na s1 e s2;

```verilog
always @(*)
begin
    flush_s1 <= 1'b0;
    flush_s2 <= 1'b0;
    flush_s3 <= 1'b0;
    stall_s1_s2 <= 1'b0;
    if(control_d1 == 1'b1 | control_d2 == 1'b1)
    begin
        flush_s1 <= 1'b1;
        flush_s2 <= 1'b1;
        flush_s3 <= 1'b0;
        stall_s1_s2 <= 1'b1;
    end
end
```
