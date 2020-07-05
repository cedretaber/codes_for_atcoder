import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto N = readln.chomp.to!long;
    if (N == 1) {
        writeln(1);
        return;
    }
    auto T = new long[][N];
    foreach (_; 1..N) {
        auto uv = readln.split.to!(long[]);
        auto u = uv[0]-1;
        auto v = uv[1]-1;
        T[u] ~= v;
        T[v] ~= u;
    }

    long r;
    foreach (i; 0..N) {
        sort(T[i]);
        if (T[i][0] > i) {
            r += (N-i) * (i+1); 
        } else {
            long prev_j = -1, d = 1;
            foreach (j; T[i]) if (j < i) --d;
            foreach (j; T[i]) if (j < i) {
                r += (j - prev_j) * (N-i) * d;
                prev_j = j;
                ++d;
            }
            r += (N-i) * (i-prev_j);
        }
    }
    writeln(r);
}