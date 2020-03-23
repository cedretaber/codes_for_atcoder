import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    if (N == 0) {
        writeln(0);
        return;
    }

    char[] r;
    foreach (i; 0..40) {
        if (N == 0) break;
        if (abs(N) & (1<<i)) {
            r ~= '1';
            N -= (-2)^^i;
        } else {
            r ~= '0';
        }
    }
    r.reverse();
    writeln(r);
}