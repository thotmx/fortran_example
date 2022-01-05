program read_from_file 
    implicit none

    ! Create a new type to organize the data
    type antoine_equation_constants_type
      character(len = 40) :: compound
      real*8 :: a, b, c
      integer :: t_min, t_max
    endtype antoine_equation_constants_type

    character(len = 40) :: compound
    real*8 :: a, b, c
    integer :: t_min, t_max

    integer :: io_stat
    integer :: counter
    integer :: number_of_constants 
    integer :: n
    namelist /constants/ compound, a, b, c, t_min, t_max 

    ! Create an array of type above with 100 elements
    type(antoine_equation_constants_type), dimension(:), allocatable :: antoine_equation_constants
    allocate(antoine_equation_constants(100))

    counter = 0
    open(unit=100, file='constants.nml', status='old', action='read')
    do
        read(100, nml=constants, iostat=io_stat)
        if (io_stat /= 0) exit
        antoine_equation_constants(counter)%compound = compound
        antoine_equation_constants(counter)%a = a
        antoine_equation_constants(counter)%b = b 
        antoine_equation_constants(counter)%c = c 
        antoine_equation_constants(counter)%t_min = t_min
        antoine_equation_constants(counter)%t_max = t_max
        !print *, compound, a, b, c, t_min, t_max 
        counter =  counter + 1
    end do
    
    number_of_constants = counter 
   
    do n = 0, number_of_constants - 1
      print *, antoine_equation_constants(n)
    end do
    close(100)
end program read_from_file
