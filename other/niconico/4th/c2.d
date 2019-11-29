import std.stdio, std.algorithm, std.conv, std.array, std.string, std.typecons;

alias GP = Tuple!(bool, int[]);

long PN = 10^^9+7;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    auto AS = readln.split.to!(int[]);
    auto BS = readln.split.to!(int[]);

    long[string] memo;
    long solve(int[] ss, int num) {
        GP[] gps;
        GP gp;
        int n = -1, m = -1;
        foreach (i, s; ss) {
            if (n == -1) {
                n = s;
            } else if (m == -1) {
                m = s;
                gp = GP(n == m, [n, m]);
            } else {
                if ((gp[0] && m == s) || (!gp[0] && m != s)) {
                    gp[1] ~= s;
                    m = s;
                } else {
                    gps ~= gp;
                    n = s;
                    m = -1;
                }
            }
        }
        if (m == -1) {
            gps ~= GP(true, [n]);
        } else {
            gps ~= gp;
        }

        long impl(int i, int rest) {
            
        }
    }
}
