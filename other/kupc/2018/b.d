import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto hw = readln.split.to!(int[]);
    auto H = hw[0];
    auto W = hw[1];
    char[][] F;
    F.length = H;
    foreach_reverse (i; 0..H) F[i] = readln.chomp.to!(char[]);
    int s;
    foreach (i; 0..W) if (F[0][i] == 's') {
        s = i;
        break;
    }

    auto impossible = "impossible".to!(char[]);
    char[] solve(int t, int s) {
        if (t == H) {
            return [];
        }
        if (s > 0 && F[t][s-1] == '.') {
            auto r = solve(t+1, s-1);
            if (r != impossible) return ['L'] ~ r;
        }
        if (s < W-1 && F[t][s+1] == '.') {
            auto r = solve(t+1, s+1);
            if (r != impossible) return ['R'] ~ r;
        }
        if (F[t][s] == '.') {
            auto r = solve(t+1, s);
            if (r != impossible) return ['S'] ~ r;
        }
        return impossible;
    }
    writeln(solve(1, s));
}
