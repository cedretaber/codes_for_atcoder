import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

int[][10] DtoS;
int[10] SS;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    foreach (i; 0..M) {
        auto kss = readln.split.to!(int[]);
        foreach (k; kss[1..$]) DtoS[i] ~= k-1;
    }
    auto PS = readln.split.to!(int[]);

    long solve(int i) {
        if (i == N) {
            foreach (j; 0..M) {
                int s;
                foreach (k; DtoS[j]) s = (s + SS[k])%2;
                if (s != PS[j]) return 0;
            }
            return 1;
        } else {
            auto r1 = solve(i+1);
            SS[i] = 1;
            auto r2 = solve(i+1);
            SS[i] = 0;
            return r1 + r2;
        }
    }

    writeln(solve(0));
}