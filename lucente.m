% Parâmetros e condições iniciais
a = 0.15; b = 0.006; c = 0.2; d = 0.0002;
n = 80;
h = 0.01; 
passos = n./h
T = ones(1,passos+1);
X = ones(1,passos+1);
t = 0;
Y = ones(1,passos+1);
x = 2000;   # Alces Iniciais
y = 15;     # Lobos Iniciais
X(1) = x;
Y(1) = y;
T(1) = 2019;

% Aplicando o Método de Euler
for t = 1:passos
    f = (a - b*y)*x;
    g = (d*x - c)*y;
    x = x + (h)*f;
    y = y + (h)*g;
    X(t+1) = x;
    Y(t+1) = y;
    T(t+1) = T(t) + h;
end

%P lotando o gráfico
figure;
plot(X,Y, 'b-');
title('Sistema Predador-Presa Lotka-Volterra');
xlabel('X (Alce/presa)');
ylabel('Y (Lobo/predador)');
grid on;
box on;
print("sistema(YxX).png", "-dpng", "-r300");
figure;
plot(T, X, 'b-', 'LineWidth', 1.5); 
hold on;
plot(T, Y, 'r-', 'LineWidth', 1.5);
title('Simulação: Lobos e Alces de Isle Royale (A partir de 2019)');
xlabel('Ano');
ylabel('População');
legend('Alces (Presas)', 'Lobos (Predadores)');
grid on;
hold off;
