import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto hw = readln.split.to!(int[]);
    auto H = hw[0];
    auto W = hw[1];
    int[][] cs;
    foreach (_; 0..H) cs ~= readln.split.to!(int[]);

    int[] xs1, ys1, xs2, ys2;
    foreach (i; 0..H) {
        foreach (j; 0..W) {
            if (cs[i][j] % 2 == 1) {
                xs1 ~= j+1;
                ys1 ~= i+1;
                if (j < W-1) {
                    cs[i][j+1] += 1;
                    xs2 ~= j+2;
                    ys2 ~= i+1;
                } else if (i < H-1) {
                    cs[i+1][j] += 1;
                    xs2 ~= j+1;
                    ys2 ~= i+2;
                }
            }
        }
    }
    writeln(xs2.length);
    foreach (i; 0..xs2.length) {
        writeln(ys1[i], " ", xs1[i], " ", ys2[i], " ", xs2[i]);
    }
}