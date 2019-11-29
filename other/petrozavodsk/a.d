import std.stdio, std.algorithm, std.conv, std.array, std.string, std.typecons;

void main()
{
    long X, Y;
    readf("%d %d", &X, &Y);

    if (X % Y == 0) {
        writeln("-1");
    } else {
        writeln(X * (Y+1));
    }
}