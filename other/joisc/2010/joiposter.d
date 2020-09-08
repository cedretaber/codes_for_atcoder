import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    auto K = nk[1];

    char[] M;
    void solve(int n, int k) {
        if (k == 0) {
            M ~= 'J';
            return;
        }

        auto d = 2^^(k-1);
        if (n <= d) {
            foreach (_; 0..d) M ~= 'J';
            foreach (_; 0..d) M ~= 'O';
            return;
        } else {
            foreach (_; 0..d) M ~= 'I';
            solve(n - d, k-1);
        }
    }
    solve(K, N);
    writeln(M);
}