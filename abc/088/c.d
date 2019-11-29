import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math;

int[3][3] CS;

void main()
{
    foreach (i; 0..3)
        CS[i][] = readln.split.to!(int[])[];

    foreach (a1; 0..201) {
        if (a1 > CS[0][0] || a1 > CS[0][1] || a1 > CS[0][2]) continue;

        auto b1 = CS[0][0] - a1;
        if (b1 > CS[1][0] || b1 > CS[2][0]) continue;

        auto a2 = CS[1][0] - b1;
        auto a3 = CS[2][0] - b1;

        auto b2 = CS[0][1] - a1;
        if (a2 + b2 != CS[1][1] || a3 + b2 != CS[2][1]) continue;

        auto b3 = CS[0][2] - a1;
        if (a2 + b3 != CS[1][2] || a3 + b3 != CS[2][2]) continue;

        writeln("Yes");
        return;
    }
    writeln("No");
}