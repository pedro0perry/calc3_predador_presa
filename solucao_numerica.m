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


% Plotando o gráfico X, Y
figure;
plot(X,Y, 'b-');
title('Sistema Predador-Presa Lotka-Volterra');
xlabel('X (Alce/presa)');
ylabel('Y (Lobo/predador)');
grid on;
box on;
print("sistema(YxX).png", "-dpng", "-r300");

% Plotando X e Y no tempo
figure;
[ax, h1, h2] = plotyy(T, X, T, Y);

set(h1, 'Color', 'b', 'LineWidth', 1.5);
set(h2, 'Color', 'r', 'LineWidth', 1.5);

title('Simulação: Lobos e Alces de Isle Royale (A partir de 2019)');
xlabel('Ano');
ylabel(ax(1), 'População de Alces (Presas)');
ylabel(ax(2), 'População de Lobos (Predadores)');
grid on;
legend([h1, h2], {'Alces (Presas)', 'Lobos (Predadores)'});
print("sistema(YxT).png", "-dpng", "-r300");

waitfor(gcf);