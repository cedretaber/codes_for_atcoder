import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto ns = readln.split.to!(int[]);
    int[] rs;
    foreach (i; 0..5) {
        foreach (j; i+1..5) {
            foreach (k; j+1..5) {
                rs ~= ns[i] + ns[j] + ns[k];
            }
        }
    }
    sort!"a > b"(rs);
    writeln(rs[2]);
}