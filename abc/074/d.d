import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.numeric, std.typecons;

void main()
{
    auto N = readln.chomp.to!int;

    int[][] AAS;
    AAS.length = N;
    foreach (ref AA; AAS) AA = readln.split.to!(int[]);

    foreach (k; 0..N)
        foreach (i; 0..N)
            foreach (j; 0..N)
                if (AAS[i][k] + AAS[k][j] < AAS[i][j])
                    goto not;
    
    if (false) {
        not:
        writeln("-1");
        return;
    }

    long sum_l = 0;
    foreach (i; 0..N) {
        foreach (j; 0..N) {
            auto flg = true;
            foreach (k; 0..N) if (k != i && k != j && AAS[i][j] == AAS[i][k] + AAS[k][j]) {
                flg = false;
                break;
            }
            if (flg) sum_l += AAS[i][j];
        }
    }
    writeln(sum_l / 2);
}