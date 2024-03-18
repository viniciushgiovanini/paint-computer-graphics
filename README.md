# Paint

## Introdução

Este programa aborda o desenvolvimento de algoritmos de computação gráfica, englobando técnicas de rasterização para desenho de retas (DDA, Bresenham) e circunferências (Bresenham), bem como algoritmos de recorte, incluindo regiões codificadas (Cohen-Sutherland) e equação paramétrica (Liang-Barsky).

**Rasterização**  
- Retas - DDA, Bresenham  
-  Circunferência - Bresenham  
  
**Recorte**  
- Regiões codificadas - Cohen-Sutherland  
- Equação paramétrica - Liang-Barsky  

## Janela Principal
![alt text](./paint_algorithm/assets/main_window.png)

## Instruções

1. Para navegar depois do zoom in você pode usar o botão do scrool ou o botão direito.
2. As ferramentas ja vem como deafult DDA e o Sutherland.
3. A ferramenta do pincel não está associada com as outras ferramentas, sendo possivel apenas apagar.
4. As retas são geradas 1 por vez na ferramenta de reta.
5. Na ferramenta de poligono é possivel gera diversas retas juntas formando objetos abertos e fechado, para começar outro objeto clique novamente na ferramenta do poligono.
6. Para criar a janela do recorte clique em pontos que gere uma diagonal principal (Esquerda para direita, cima baixo), caso queira deleta o retangulo do corte faça um retangulo com pontos na diagonal secundaria.
7. Todas as transformações geométricas são realizadas no ultimo objetos desenhado, pode ser reta ou poligono.
8. Exemplo de Input das transformações geométricas.
   1. Translação: Clique em um novo local na tela.
   2. Rotação: Valor do angulo (90, 60).
   3. Escala: Fator escala, numero decimal.
   4. Reflexão: Eixos da reflexão (x, y, xy) em lowercase. 

## Path
- O projeto foi desenvolvido em flutter, por esse motivo os arquivos principais estão no path abaixo:
```
paint_algorithm/lib/*.
```
- Os arquivos contendo o algoritmos estão no mesmo path porem na pasta algoritmo:
```
paint_algorithm/lib/algorithms/*.
```

## Arquivo Executavel (Build para Windows)



## Linguagens de Programação

<img src="https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/dart/dart-original.svg" width="50px"/>&nbsp;
<img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/flutter/flutter-original.svg" width="50px"/>

---

## Desenvolvimento ✏

**Feito por**:
- [Vinícius Henrique Giovanini](https://github.com/viniciushgiovanini)  
