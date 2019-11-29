import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math;
 
long[10^^5] LS, RS;
 
void main()
{
    auto nd = readln.split.to!(long[]);
    auto N = nd[0];
    auto D = nd[1];
    auto XS = readln.split.to!(long[]);
 
    size_t j;
    foreach (i, x; XS) {
        while (j < N-1 && XS[j] - x <= D) ++j;
        if (XS[j] - x > D) --j;
        LS[i] = j - i;
    }
    j = N-1;
    foreach_reverse (i, x; XS) {
        while (j > 0 && x - XS[j] <= D) --j;
        if (x - XS[j] > D) ++j;
        RS[i] = i - j;
    }
 
    long iv;
    foreach (i; 0..N-2) if (LS[i] > 1)
        iv += LS[i] * (LS[i] - 1) / 2;
    
    long al;
    foreach (i; 1..N-1)
        al += LS[i] * RS[i];
 
    writeln(al - iv);
}