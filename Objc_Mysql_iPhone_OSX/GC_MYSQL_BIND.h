//
//  GC_MYSQL_BIND.h
//  mysql_connector
//
//  Created by Karl Kraft on 5/1/10.
//  Copyright 2010 Karl Kraft. All rights reserved.
//


/*
 MYSQL_BIND is used by this Objective-C mysql library to pass data to 
 mysql_stmt_bind_param() and ultimately mysql_stmt_execute().
  
 The problem is that some members of the structure end up with pointers to auto collected 
 memory (in particular the results of calling -[NSString UTF8String]).   
 
 Since these structure members don't have a __strong attribute, the memory can be garbage 
 collected and reused between the time of binding, and the call to mysql_stmt_execute().  
 This can result in garbage in the database. 
 
 Here we redeclare this structure with the attributes, and then use this modified version.
  
 */

#if defined(__LP64__) || defined(NS_BUILD_32_LIKE_64)

typedef struct gc_st_mysql_bind
{
  unsigned long	*__strong length;          /* output length pointer */
  my_bool       *__strong is_null;	  /* Pointer to null indicator */
  void		*__strong buffer;	  /* buffer to get/put data */
  /* set this if you want to track data truncations happened during fetch */
  my_bool       *__strong error;
  unsigned char *__strong row_ptr;         /* for the current data position */
  void (*store_param_func)(NET *net, struct st_mysql_bind *param);
  void (*fetch_result)(struct st_mysql_bind *, MYSQL_FIELD *,
                       unsigned char **row);
  void (*skip_result)(struct st_mysql_bind *, MYSQL_FIELD *,
                      unsigned char **row);
  /* output buffer length, must be set when fetching str/binary */
  unsigned long buffer_length;
  unsigned long offset;           /* offset position for char/binary fetch */
  unsigned long	length_value;     /* Used if length is 0 */
  unsigned int	param_number;	  /* For null count and error messages */
  unsigned int  pack_length;	  /* Internal length for packed data */
  enum enum_field_types buffer_type;	/* buffer type */
  my_bool       error_value;      /* used if error is 0 */
  my_bool       is_unsigned;      /* set if integer type is unsigned */
  my_bool	long_data_used;	  /* If used with mysql_send_long_data */
  my_bool	is_null_value;    /* Used if is_null is 0 */
  void *extension;
} GC_MYSQL_BIND;

#else

typedef struct gc_st_mysql_bind
{
  unsigned long	*__strong length;          /* output length pointer */
  my_bool       *__strong is_null;	  /* Pointer to null indicator */
  void		*__strong buffer;	  /* buffer to get/put data */
  /* set this if you want to track data truncations happened during fetch */
  my_bool       *__strong error;
  unsigned char *__strong row_ptr;         /* for the current data position */
  void (*store_param_func)(NET *net, struct st_mysql_bind *param);
  void (*fetch_result)(struct st_mysql_bind *, MYSQL_FIELD *,
                       unsigned char **row);
  void (*skip_result)(struct st_mysql_bind *, MYSQL_FIELD *,
                      unsigned char **row);
  /* output buffer length, must be set when fetching str/binary */
  unsigned long buffer_length;
  unsigned long offset;           /* offset position for char/binary fetch */
  unsigned long	length_value;     /* Used if length is 0 */
  unsigned int	param_number;	  /* For null count and error messages */
  unsigned int  pack_length;	  /* Internal length for packed data */
  enum enum_field_types buffer_type;	/* buffer type */
  my_bool       error_value;      /* used if error is 0 */
  my_bool       is_unsigned;      /* set if integer type is unsigned */
  my_bool	long_data_used;	  /* If used with mysql_send_long_data */
  my_bool	is_null_value;    /* Used if is_null is 0 */
  void *extension;
} GC_MYSQL_BIND;

#endif

