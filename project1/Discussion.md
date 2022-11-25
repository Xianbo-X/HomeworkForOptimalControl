## Project1

### Assignment2

$F[i][j]$ 为第i个字母以j为起始点画完整个消息的最小消耗。

Base case m: length of our message 
$F[m][k]=dist[k]$ dist[k] 以k为起始点画完字母的最小消耗。 其结束点为link[k]

i<3
$$
\begin{aligned}
&F[i][j]= min_k F[i+1][k] + cost(j,k)\\
&=> F[i][j]=min_k {F[i+1][k] + min_m {cost[j][m]+dist(m,k)} }\\
&=> F[i][j]=min_k min_m \{  {F[i+1][k] +cost[j][m]+dist(m,k)} \}
\end{aligned}
$$
dist(m,k) => Eucliden distance between point m and k

$cost[i][k]$=> minimal cost of finishing a letter from i to k
$$
Result*=min_k (F[0][k]+|| init-point(k)  ||) \\
Result= min_k F[0][k]
$$
