import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    readln;
    auto as = readln.split.to!(long[]);
    long res;
    while (as.length > 1) {
        size_t i;
        auto min_d = long.max;
        foreach (j; 0..as.length-1) if (as[j] + as[j+1] < min_d) {
            min_d = as[j] + as[j+1];
            i = j;
        }
        long[] bs;
        foreach (j; 0..as.length) {
            if (j == i) {
                res += as[j] + as[j+1];
                bs ~= as[j] + as[j+1];
            } else if (j-1 != i) {
                bs ~= as[j];
            }
        }
        as = bs;
    }
    writeln(res);
}