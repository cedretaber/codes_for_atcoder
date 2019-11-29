import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto LS = readln.split.to!(int[]);
    sort(LS);
    long res;
    foreach (i; 0..N-2) {
        foreach (j; i+1..N-1) {
            auto a = LS[i], b = LS[j];
            auto ll = max(a-b, b-a);
            auto rl = a+b;

            if (LS[j+1] >= rl || LS[N-1] <= ll) continue;

            int l = j+1, r = N-1;

            if (LS[j+1] > ll) {
                ll = j+1;
            } else {
                while (l+1 < r) {
                    auto m = (l+r)/2;
                    if (LS[m] > ll) {
                        r = m;
                    } else {
                        l = m;
                    }
                }
                ll = r;
            }

            if (LS[N-1] < rl) {
                rl = N-1;
            } else {
                l = j+1;
                r = N-1;
                while (l+1 < r) {
                    auto m = (l+r)/2;
                    if (LS[m] < rl) {
                        l = m;
                    } else {
                        r = m;
                    }
                }
                rl = l;
            }
            res += rl - ll + 1;
        }
    }
    writeln(res);
}