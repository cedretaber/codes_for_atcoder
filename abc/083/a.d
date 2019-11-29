import std.stdio, std.algorithm, std.conv, std.array, std.string;

void main()
{
    int A, B, C, D;
    readf("%d %d %d %d", &A, &B, &C, &D);
    writeln(A+B > C+D ? "Left" : A+B < C+D ? "Right" : "Balanced");
}