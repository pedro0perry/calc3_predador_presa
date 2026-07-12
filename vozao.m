% --- Parâmetros da Ilha Royale ---
a = 0.15;
b = 0.006;
c = 0.2;
d = 0.0002;

% --- Condições Iniciais e Ponto de Equilíbrio ---
x0 = 2000;
y0 = 15;
eqX = c / d;
eqY = a / b;

% --- Função de Energia do Ecossistema V(x,y) ---
% Operadores com ponto (.*, ./) permitem cálculos vetorizados em matrizes
V = @(x, y) d.*x - c.*log(x) + b.*y - a.*log(y);

% Condição inicial
C0 = V(x0, y0);

% --- Configuração das Malhas de Dados ---
% Malha densa para as curvas de nível
[X, Y] = meshgrid(linspace(100, 3000, 400), linspace(1, 80, 400));
Z = V(X, Y);

% Malha mais espaçada para o campo de vetores (evita poluição visual)
[X_vetor, Y_vetor] = meshgrid(linspace(150, 2850, 22), linspace(3, 77, 15));
u = X_vetor .* (a - b .* Y_vetor);
v = Y_vetor .* (-c + d .* X_vetor);

% Normalização dos vetores para simular o efeito visual do StreamPlot
L = sqrt(u.^2 + v.^2);
u_norm = u ./ (L + eps);
v_norm = v ./ (L + eps);

% --- Criação do Gráfico ---
figure('Position', [100, 100, 850, 600]);
hold on;

% 2. Curvas de Nível (Órbitas Fechadas)
% Órbita inicial (C0) em Azul e Espessa
contour(X, Y, Z, [C0, C0], 'LineColor', 'b', 'LineWidth', 2);

% Órbitas externas em Cinza e Tracejadas
niveis_extras = [C0 - 0.025, C0 - 0.5, C0 + 0.05, C0 + 0.1, C0 + 0.2];
contour(X, Y, Z, niveis_extras, 'LineColor', [0.4 0.4 0.4], 'LineStyle', '--', 'LineWidth', 1.2);

% 3. Marcação dos Pontos Relevantes
% Ponto de Equilíbrio P2
plot(eqX, eqY, 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r');
text(eqX - 100, eqY + 3.5, 'P2 (1000, 25)', 'Color', 'r', 'FontSize', 12, 'FontWeight', 'bold');

% Ponto Inicial
plot(x0, y0, 'ko', 'MarkerSize', 7, 'MarkerFaceColor', 'k');
text(x0 - 150, y0 + 3.5, 'Início (2000, 15)', 'Color', 'k', 'FontSize', 12, 'FontWeight', 'bold');

% --- Formatação Final ---
axis([0 3000 0 80]);
xlabel('População de Alces (x)', 'FontSize', 14);
ylabel('População de Lobos (y)', 'FontSize', 14);
title('Retrato de Fase e Curvas de Nível (Ilha Royale)', 'FontSize', 16, 'FontWeight', 'bold');
set(gca, 'FontSize', 12, 'FontName', 'Helvetica');
grid on;
box on;
hold off;
waitfor(gcf);