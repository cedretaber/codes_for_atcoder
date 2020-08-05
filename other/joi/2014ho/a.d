import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto mn = readln.split.to!(int[]);
    auto M = mn[0];
    auto N = mn[1];

    char[][] F;
    foreach (_; 0..M) F ~= readln.chomp.to!(char[]);
    char[2][2] C;
    foreach (i; 0..2) {
        auto l = readln.chomp.to!(char[]);
        C[i][0] = l[0];
        C[i][1] = l[1];
    }

    bool match(int i, int j) {
        if (i < 0 || i >= M-1 || j < 0 || j >= N-1) return false;

        static foreach (a; [0,1])
        static foreach (b; [0,1]) {
            if (F[i+a][j+b] != C[a][b]) return false;
        }
        return true;
    }

    int s;
    foreach (i; 0..M-1) foreach (j; 0..N-1) if (match(i, j)) ++s;

    int r;
    foreach (i; 0..M) foreach (j; 0..N) {
        auto o = F[i][j];

        static foreach (c; "JOI") {{
            int d;
            static foreach (id; [-1,0,1])
            static foreach (jd; [-1,0,1]) {{
                auto org = match(i+id, j+jd);
                F[i][j] = c;
                auto cur = match(i+id, j+jd);
                F[i][j] = o;
                if (org && !cur) {
                    --d;
                } else if (!org && cur) {
                    ++d;
                }
            }}
            r = max(r, s + d);
        }}
        F[i][j] = o;
    }

    writeln(r);
}