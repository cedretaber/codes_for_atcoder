import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto hw = readln.split.to!(int[]);
    auto H = hw[0];
    auto W = hw[1];
    int[][] AS;
    AS.length = H;
    foreach (i; 0..H) AS[i] = readln.split.to!(int[]);

    int min_c = int.max;
    foreach (y; 0..H) {
        foreach (x; 0..W) {
            int c;
            foreach (j; 0..H) {
                foreach (i; 0..W) {
                    c += min(abs(y-j), abs(x-i)) * AS[j][i];
                }
            }
            min_c = min(c, min_c);
        }
    }
    writeln(min_c);
}